#include"stdio.h"
int main(){
int A[10], *p, N, *end;
p = &A[0]; N = 100;
end = &A[10];

while (p < end) {
if (*p < N) {
   *p += N;
}
else {
*p -= 1;
}
 p++;
}

return 0;
}
