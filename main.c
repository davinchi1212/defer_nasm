#include <stdio.h> 

extern void Defer(void*(f)) ; 
extern void ReturnDef() ; 
void foo() {
    for (int i = 0 ; i < 5 ; ++ i ) {
        printf("foo was in defer [%d] \n", i ) ; 
    }
}
void bar() {
    for (int j = 5 ; j >= 0 ; --j ) {
        printf("bar was in defer [%d]\n", j ) ; 
    }

}
int main() {
    printf("1st line\n") ; 
    Defer(foo) ; 
    printf("2sd line\n") ; 
    Defer(bar) ; 
    printf("3rd line\n") ;
    ReturnDef() ; 
    printf("line after ReturnDefer\n");
}
