// antlr4 -package parser -o antlr-generated  -no-listener parser/TinyPiS.g4
grammar TinyPiS;

prog: varDecls stmt
    ;

varDecls: ('var' IDENTIFIER ';')*
	  ;

stmt: '{' stmt* '}'				# compoundStmt
    | IDENTIFIER '=' expr ';'			# assignStmt
    | 'print' expr ';'	  			# printStmt
    | 'if' '(' expr ')' stmt 'else' stmt	# ifStmt
    | 'while' '(' expr ')' stmt	    		# whileStmt
    ;

expr: orExpr
      ;

orExpr: orExpr OROP andExpr
	| andExpr
	;
	
andExpr: andExpr ANDOP addExpr
	| addExpr
	;

addExpr: addExpr ADDOP mulExpr
	| mulExpr
	;

mulExpr: mulExpr MULOP unaryExpr
	| unaryExpr
	;

unaryExpr: NOTOP unaryExpr	# notExpr
	| ADDOP unaryExpr	# minusExpr
	| VALUE			# literalExpr
	| IDENTIFIER		# varExpr
	| '(' expr ')'		# parenExpr
	;
	
ADDOP: '+'|'-';
MULOP: '*'|'/';
ANDOP: '&';
OROP: '|';
NOTOP: '~';

IDENTIFIER: [a-zA-Z_]+[a-zA-Z0-9_]*;
VALUE: [0-9]|[1-9][0-9]+;
WS: [ \t\r\n] -> skip;