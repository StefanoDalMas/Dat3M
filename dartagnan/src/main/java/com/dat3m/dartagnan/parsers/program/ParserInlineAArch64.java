package com.dat3m.dartagnan.parsers.program;

import java.util.ArrayList;

import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.DiagnosticErrorListener;
import org.antlr.v4.runtime.ParserRuleContext;

import com.dat3m.dartagnan.exception.AbortErrorListener;
import com.dat3m.dartagnan.expression.Expression;
import com.dat3m.dartagnan.expression.Type;
import com.dat3m.dartagnan.parsers.InlineAArch64Lexer;
import com.dat3m.dartagnan.parsers.InlineAArch64Parser;
import com.dat3m.dartagnan.parsers.program.visitors.VisitorInlineAArch64;
import com.dat3m.dartagnan.program.Function;
import com.dat3m.dartagnan.program.Program;
import com.dat3m.dartagnan.program.Register;

public class ParserInlineAArch64 implements ParserInterface {

    private VisitorInlineAArch64 visitor;
    private final Function llvmFunction;
    private final Register returnRegister;
    private final Type returnType;
    private final ArrayList<Expression> argumentsRegisterAddresses;

    public ParserInlineAArch64(Function function, Register returnRegister,Type returnType,ArrayList<Expression> argumentsRegisterAddresses){
        this.llvmFunction = function;
        this.returnRegister = returnRegister;
        this.returnType = returnType;
        this.argumentsRegisterAddresses = argumentsRegisterAddresses;
    }
    public VisitorInlineAArch64 getVisitor(){
        return this.visitor;
    }

    @Override
    public Program parse(CharStream charStream) {
        InlineAArch64Lexer lexer = new InlineAArch64Lexer(charStream);
        lexer.addErrorListener(new AbortErrorListener());
        lexer.addErrorListener(new DiagnosticErrorListener(true));
        CommonTokenStream tokenStream = new CommonTokenStream(lexer);

        InlineAArch64Parser parser = new InlineAArch64Parser(tokenStream);
        parser.addErrorListener(new AbortErrorListener());
        ParserRuleContext parserEntryPoint = parser.asm();
        visitor = new VisitorInlineAArch64(this.llvmFunction,this.returnRegister, this.returnType, this.argumentsRegisterAddresses);
        return (Program) parserEntryPoint.accept(visitor);
    }
}