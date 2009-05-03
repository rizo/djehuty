module parseunit;

import feeder;
import ast;

import core.string;
import core.unicode;
import core.definitions;

import console.main;

//import std.stdio;
//import std.file;
//import std.string;

class ParseUnit
{
	final void attachFeeder(Feeder feed)
	{
		feeder = feed;
	}

	final AST parse()
	{
		// get class name
		ClassInfo ci = this.classinfo;
		String className = new String(Unicode.toNative(ci.name));

		Console.putln("CLASS: ", className.array);

		original = new AST(null,null);
		parseTree = original;

		int pos = className.findReverse(new String("."));
		if (pos > 0)
		{
			className = new String(className[pos+1..className.length]);
		}
		Console.putln("CLASS: ", className.array);
		
		parseTree.name = className;

		for(;;)
		{
			if (tokens is null)
			{
				tokens = feeder.feed();
				idx = 0;

				if (tokens is null) { return original; }
			}

			for( ; idx < tokens.length ; idx++)
			{
				currentToken = tokens[idx];
				if (currentToken.array in parseFunctions)
				{
					parseFunctions[currentToken.array]();
				}
				else
				{
					parseDefault();
				}
				
				// Finished?
				if (iAmDone) { idx++; return original; }
			}

			// get more
			tokens = feeder.feed();
			idx=0;
		}
		
		return original;
	}
	
	void progressTree(AST right)
	{
		if (parseTree.right !is null && parseTree.left is null)
		{
			parseTree.left = new AST(null, null);
			parseTree = parseTree.left;
		}
				
		parseTree.right = right;
		
		if (parseTree !is original && right !is null && right.valueType == AST.ValueType.Name)
		{
			String val;
			right.getValue(val);
			parseTree.hint = val;
		}
	}
	
protected:

	// feed state
	static String[] tokens;
	static uint idx;

	static Feeder feeder;

	alias void delegate() ParseFunction;

	ParseFunction[Char[]] parseFunctions;

	ParseUnit parseUnit;
	
	AST parseTree;
	AST original;

	bool iAmDone;
	
	String currentToken;
	
	AST newParseUnit(ParseUnit newUnit)
	{
		parseUnit = newUnit;
		return parseUnit.parse();
	}
	
	void done()
	{
		iAmDone = true;
	}
	
	void registerToken(String token, ParseFunction func)
	{
		parseFunctions[token.array] = func;
	}
	
	void registerToken(StringLiteral token, ParseFunction func)
	{
		parseFunctions[token] = func;
	}
	
	void parseDefault()
	{
		return false;
	}
}