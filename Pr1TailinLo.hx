
/* Token Definition */
module org.crsx.hacs.samples.Pr1TailinLo {
space 
	 [ \t\n] 
	| "//" (.)*
	| "/*" ([^*] | "*"  [^/])*  "*/"
	;

// main token definition
token IDENTIFIER 
	| ([$_] | ⟨Letter⟩) ([$_] | ⟨Letter⟩ | ⟨Digit⟩)* 
    	;
token INTEGER 
	| ⟨Digit⟩+ 
	;
token STRING
	| "\'" ([^\'\\\n] | \\ ⟨Escape⟩)* "\'" 
	| "\"" ([^\"\\\n] | \\ ⟨Escape⟩)* "\""
	;

// ⟨⟩ 
// ⟦⟧

// fragment token definition
token fragment Letter         | [A-Za-z] ;
token fragment Digit          | [0-9] ;
token fragment Escape         | [\n'"\\nt] | "x" ⟨Hex⟩ ⟨Hex⟩ ;
token fragment Hex            | [0-9A-Fa-f] ;

/* Expression Definition */

// ⟨⟩ 

sort Expr
	|  ⟦ ⟨IDENTIFIER⟩ ⟧@15
	|  ⟦ ⟨INTEGER⟩ ⟧@15
	|  ⟦ ⟨STRING⟩ ⟧@15
	|  sugar ⟦ ( ⟨Expr#⟩ ) ⟧@15 → Expr#
	
	|  ⟦ ⟨Expr@14⟩ . ⟨Expr@14⟩ ⟧@14

	|  ⟦ ⟨Expr@13⟩ ( ⟨ExprList⟩ ) ⟧@13

	|  ⟦ ! ⟨Expr@12⟩ ⟧@12
	|  ⟦ ~ ⟨Expr@12⟩ ⟧@12
	|  ⟦ - ⟨Expr@12⟩ ⟧@12
	|  ⟦ + ⟨Expr@12⟩ ⟧@12

	|  ⟦ ⟨Expr@11⟩ * ⟨Expr@12⟩ ⟧@11
	|  ⟦ ⟨Expr@11⟩ / ⟨Expr@12⟩ ⟧@11
	|  ⟦ ⟨Expr@11⟩ % ⟨Expr@12⟩ ⟧@11

	|  ⟦ ⟨Expr@10⟩ + ⟨Expr@11⟩ ⟧@10
	|  ⟦ ⟨Expr@10⟩ - ⟨Expr@11⟩ ⟧@10

	|  ⟦ ⟨Expr@9⟩ < ⟨Expr@9⟩ ⟧@9
	|  ⟦ ⟨Expr@9⟩ > ⟨Expr@9⟩ ⟧@9
	|  ⟦ ⟨Expr@9⟩ <= ⟨Expr@9⟩ ⟧@9
	|  ⟦ ⟨Expr@9⟩ >= ⟨Expr@9⟩ ⟧@9

	|  ⟦ ⟨Expr@8⟩ == ⟨Expr@8⟩ ⟧@8
	|  ⟦ ⟨Expr@8⟩ != ⟨Expr@8⟩ ⟧@8

	|  ⟦ ⟨Expr@7⟩ & ⟨Expr@8⟩ ⟧@7
	
	|  ⟦ ⟨Expr@6⟩ ^ ⟨Expr@7⟩ ⟧@6

	|  ⟦ ⟨Expr@5⟩ | ⟨Expr@6⟩ ⟧@5
	
	|  ⟦ ⟨Expr@4⟩ && ⟨Expr@5⟩ ⟧@4
	
	|  ⟦ ⟨Expr@3⟩ || ⟨Expr@4⟩ ⟧@3
	
	|  ⟦ ⟨Expr@3⟩ ? ⟨Expr@2⟩ : ⟨Expr@2⟩ ⟧@2

	|  ⟦ ⟨Expr@1⟩ = ⟨Expr@2⟩ ⟧@1 			
	|  ⟦ ⟨Expr@1⟩ += ⟨Expr@2⟩ ⟧@1     		
	|  ⟦ ⟨Expr@1⟩ = { ⟨FieldList⟩ } ⟧@1 
	;

sort ExprList
	| ⟦ ⟨Expr⟩ ⟨ExprTail⟩ ⟧
	| ⟦⟧
	;

sort ExprTail
	| ⟦ , ⟨Expr⟩⟨ExprTail⟩ ⟧
	| ⟦⟧
	; 

sort FieldList
	| ⟦ ⟨FieldHead⟩ ⟨FieldTail⟩ ⟧ 
	| ⟦⟧
	;

sort FieldHead 
	| ⟦ ⟨IDENTIFIER⟩ : ⟨Expr⟩ ⟧
	;

sort FieldTail
	| ⟦ , ⟨FieldHead⟩ ⟨FieldTail⟩ ⟧
	| ⟦⟧
	;

/* Type Definition */

sort Type
	| ⟦ boolean ⟧
	| ⟦ number ⟧
	| ⟦ string ⟧
	| ⟦ void ⟧
	| ⟦ ⟨IDENTIFIER⟩ ⟧
	| ⟦ ( ⟨TypeList⟩ ) => ⟨Type⟩ ⟧
	| ⟦ { ⟨FieldTypeList⟩ } ⟧
	; 

sort TypeList
	| ⟦ ⟨Type⟩ ⟨TypeTail⟩ ⟧
	| ⟦⟧
	;

sort TypeTail
	| ⟦ , ⟨Type⟩ ⟨TypeTail⟩ ⟧
	| ⟦⟧
	;

sort FieldTypeList
	| ⟦ ⟨FiledTypeHead⟩ ⟨FiledTypeTail⟩ ⟧
	| ⟦⟧
	;

sort FiledTypeHead
	| ⟦ ⟨IDENTIFIER⟩ : ⟨Type⟩ ⟧
	;

sort FiledTypeTail
	| ⟦ , ⟨FiledTypeHead⟩ ⟨FiledTypeTail⟩ ⟧
	| ⟦⟧
	;

/* Statement Definition */

sort Stat
	| ⟦ { ⟨StatList⟩ } ⟧
	| ⟦ var ⟨IDENTIFIER⟩ : ⟨Type⟩ ; ⟧
	| ⟦ ⟨Expr⟩ ; ⟧
	| ⟦ ; ⟧
	| ⟦ if ( ⟨Expr⟩ ) ⟨Stat⟩ ⟧
	| ⟦ if ( ⟨Expr⟩ ) ⟨Stat⟩ else ⟨Stat⟩ ⟧
	| ⟦ while ( ⟨Expr⟩ ) ⟨Stat⟩ ⟧
	| ⟦ return ⟨Expr⟩ ; ⟧
	| ⟦ return ; ⟧
	;

sort StatList
	| ⟦ ⟨Stat⟩ ⟨StatList⟩ ⟧
	| ⟦⟧
	;

/* Declaration Definition */

sort Decl
	| ⟦ interface ⟨IDENTIFIER⟩ { ⟨MemberList⟩ } ⟧
	| ⟦ function ⟨IDENTIFIER⟩ ⟨CallSig⟩ { ⟨StatList⟩ } ⟧
	;

sort MemberList
	| ⟦ ⟨MemberHead⟩ ⟨MemberList⟩ ⟧
	| ⟦⟧
	;

sort MemberHead
	| ⟦ ⟨IDENTIFIER⟩ : ⟨Type⟩ ; ⟧
	| ⟦ ⟨IDENTIFIER⟩ ⟨CallSig⟩ { ⟨StatList⟩ } ⟧
	;

sort CallSig
	| ⟦ ( ⟨CallSigHead⟩ ⟨CallSigTail⟩ ) : ⟨Type⟩ ⟧
	;

sort CallSigHead
	| ⟦ ⟨IDENTIFIER⟩ : ⟨Type⟩ ⟧
	| ⟦⟧
	;

sort CallSigTail
	| ⟦ , ⟨CallSigHead⟩ ⟨CallSigTail⟩ ⟧
	| ⟦⟧
	;

/* Main Start Definition */

main sort Program
	| ⟦ ⟨Code⟩ ⟨CodeList⟩ ⟧ 
	;

sort Code
	| ⟦ ⟨Stat⟩ ⟧
	| ⟦ ⟨Decl⟩ ⟧
	;

sort CodeList
	| ⟦ ⟨Code⟩ ⟨CodeList⟩ ⟧
	| ⟦⟧
	;

}
