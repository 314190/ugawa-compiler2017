// antlr4 -package parser -o antlr-generated  -no-listener parser/TinyPiE.g4
grammar TinyPiE;

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
	| IDENTIFIER			# varExpr
	| '(' expr ')'		# parenExpr
	;

ADDOP: '+'|'-';
MULOP: '*'|'/';
ANDOP: '&';
OROP: '|';

NOTOP: '~';

IDENTIFIER: 'x'|'y'|'z';
VALUE: [0-9]|[1-9][0-9]+;
WS: [ \t\r\n] -> skip;
