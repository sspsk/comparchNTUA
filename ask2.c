#include"stdio.h"

int sum1(int n, int k){
  int i,res=0;
  for(i=n;i<=k;i++){
    res += i;
  }
  return res;
}

int sum2(int n,int k){
  if(n > k) return 0;
  return n + sum2(n+1,k);
}

int main(){
  int n1, n2;
  scanf("%d %d",&n1,&n2);
  printf("%d\n", sum1(n1,n2));
  return 0;
}
