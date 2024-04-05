lexer grammar CSharpRoutineLexer;

// Keywords
TYPE_BOOLEAN: 'bool';
TYPE_CHAR: 'char';
TYPE_FLOAT32: 'float';
TYPE_FLOAT64: 'double';
TYPE_FLOAT128: 'decimal';
TYPE_INT8: 'sbyte';
TYPE_INT16: 'short';
TYPE_INT32: 'int';
TYPE_INT64: 'long';
TYPE_UINT8: 'byte';
TYPE_UINT16: 'ushort';
TYPE_UINT32: 'uint';
TYPE_UINT64: 'ulong';
TYPE_STRING: 'string'; // 16 bits per character

NODE: '@node';
LEASE: '@lease';

BREAK: 'break';     // used for switch
CASE: 'case';       // used for switch
DEFAULT: 'default'; // used for switch
IF: 'if';
ELSE: 'else';
SWITCH: 'switch';

// Integer Literals
INTEGER_LITERAL
    : DecIntegerLiteral
    | HexIntegerLiteral
    | OctalIntegerLiteral
    | BinaryIntegerLiteral
;

fragment DecIntegerLiteral: '0' | NonZeroDigit Digit*;
fragment HexIntegerLiteral: '0' [xX] HexDigit+;
fragment OctalIntegerLiteral: '0' Digit+;
fragment BinaryIntegerLiteral: '0' [bB] BinaryDigit+;

// Floating-Point Literals
FLOATING_POINT_LITERAL: DecFloatingPointLiteral;

fragment DecFloatingPointLiteral
    : DecIntegerLiteral? ('.' Digits) FloatTypeSuffix?
    | DecIntegerLiteral FloatTypeSuffix?
;

// Boolean Literals
BOOLEAN_LITERAL: 'true' | 'false';

// Character Literals
CHARACTER_LITERAL
    : '\'' SingleCharacter '\''
    | '\'' EscapeSequence '\''
;

fragment SingleCharacter: ~['\\\r\n];
fragment EscapeSequence
    : '\\\''
    | '\\"'
    | '\\\\'
    | '\\0'
    | '\\a'
    | '\\b'
    | '\\f'
    | '\\n'
    | '\\r'
    | '\\t'
    | '\\v'
;

// String Literals
STRING_LITERAL: '"' StringCharacters? '"';
fragment StringCharacters: StringCharacter+;
fragment StringCharacter: ~["\\\r\n] | EscapeSequence;

// Null Literal
NULL_LITERAL: 'null';

// Separators
LPAREN: '(';
RPAREN: ')';
LBRACE: '{';
RBRACE: '}';
LBRACK: '[';
RBRACK: ']';
SEMI: ';';
COMMA: ',';
DOT: '.';
COLON: ':';
COLONCOLON: '::';

// Operators
ASSIGN: '=';
ADD_ASSIGN: '+=';
SUB_ASSIGN: '-=';
MUL_ASSIGN: '*=';
DIV_ASSIGN: '/=';
AND_ASSIGN: '&=';
OR_ASSIGN: '|=';
XOR_ASSIGN: '^=';
MOD_ASSIGN: '%=';
LSHIFT_ASSIGN: '<<=';
RSHIFT_ASSIGN: '>>=';

GT: '>';
LT: '<';
EQUAL: '==';
LE: '<=';
GE: '>=';
NOTEQUAL: '!=';
NOT: '!';

BIT_NOT: '~';
BIT_AND: '&';
BIT_OR: '|';
BIT_XOR: '^';
/* Defining these here make recognizing scheduled blocks difficult BIT_SHIFT_L: '<<'; BIT_SHIFT_R:
 '>>';
 */

AND: '&&';
OR: '||';

INC: '++';
DEC: '--';

ADD: '+';
SUB: '-';
MUL: '*';
DIV: '/';
MOD: '%';

TERNARY: '?';

// Identifiers
/* Order affects precedence IDENTIFIER must come last. */
IDENTIFIER: Letter LetterOrDigit*;

fragment LetterOrDigit: Letter | Digit;
fragment Digits: Digit+;
fragment Digit: '0' | NonZeroDigit;
fragment NonZeroDigit: [1-9];
fragment HexDigit: [0-9a-fA-F];
fragment BinaryDigit: [01];
fragment Letter: [a-zA-Z_];
fragment FloatTypeSuffix: [fFdD];

// Whitespace and Comments
WHITESPACE: [ \t\r\n\u000C]+ -> skip;
COMMENT_BLOCK: '/*' .*? '*/' -> channel(HIDDEN);
COMMENT_LINE: '//' ~[\r\n]* -> channel(HIDDEN);