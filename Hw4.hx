
module cc.Hw4 {
// ⟨⟩
// ⟦⟧
	/* Lexical Analysis */
	
	space [ \t\n];
	token NUM | ⟨Digit⟩+;
	token fragment Digit | [0-9];
	
	/* Syntax Analysis */
		
	sort L 
	| ⟦ ⟨NUM⟩ ⟨L⟩ ⟧
	| ⟦ { ⟨L⟩ } ⟨L⟩ ⟧
	| ⟦⟧
	;
	
	/* Semantic Analysis */
	
	sort Computed;
	| scheme Product(L);
	| scheme ProductHelper(L, Computed);
	Product(#) → ProductHelper(#, ⟦1⟧);
	ProductHelper(⟦⟧,#) → #;
	ProductHelper(⟦ ⟨NUM#1⟩ ⟨L#2⟩ ⟧,#) → ProductHelper(#2, ⟦#1*#⟧);
	ProductHelper(⟦ { ⟨L#1⟩ } ⟨L#2⟩ ⟧,#) → ProductHelper(#2, ProductHelper(#1,#));

	sort L;
	| scheme Flatten(L);
	| scheme FlattenHelper(L,L);
	Flatten(#) → FlattenHelper(#,⟦⟧);
	FlattenHelper(⟦⟧,#) → #;
	FlattenHelper(⟦ ⟨NUM#1⟩ ⟨L#2⟩ ⟧,#) → ⟦ ⟨NUM#1⟩ ⟨L FlattenHelper(#2,#)⟩ ⟧; 
	FlattenHelper(⟦ { ⟨L#1⟩ } ⟨L#2⟩ ⟧,#) → FlattenHelper(FlattenHelper(#1,#2),#);

	sort L;
	| scheme Reverse(L);
	| scheme ReverseHelper(L,L); 
	Reverse(#) → ReverseHelper(#,⟦⟧);
	ReverseHelper(⟦⟧,#) → #;
	ReverseHelper(⟦ ⟨NUM#1⟩ ⟨L#2⟩ ⟧,#) → ReverseHelper(#2,⟦ ⟨NUM#1⟩ ⟨L#⟩ ⟧);
	ReverseHelper(⟦ { ⟨L#1⟩ } ⟨L#2⟩ ⟧,#) → ReverseHelper(#2, ⟦ { ⟨L Reverse(#1)⟩ }  ⟨L#⟩ ⟧);
	
}
