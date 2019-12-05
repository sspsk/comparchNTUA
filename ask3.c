#include"stdio.h"
#include"stdlib.h"

struct node {
  int key;
  struct node * left;
  struct node * right;

};
typedef struct node node;

node * insert(node * root, int key){
  if(root == NULL){
  root = malloc(sizeof(node));
  root->left = NULL;
  root->right = NULL;
  root->key = key;
  return root;
  }
  else{
    if(root->key > key) root->left = insert(root->left,key);
    else root->right = insert(root->right,key);
    return root;
  }


}

node * bst_search(node * root, int key){
  if(root == NULL || root->key == key)return root;
  if(root->key > key) return bst_search(root->left,key);
  return bst_search(root->right,key);
}

int main(){
  node* root = NULL, *ptr;
  root = insert(root,5);
  root = insert(root,6);
  root = insert(root,9);
  root = insert(root,34);
  root = insert(root,3);
  root = insert(root,4);
  root = insert(root,64);
  ptr = bst_search(root,64);
  if(ptr == NULL) printf("does not exist\n");
  else printf("%d\n",ptr->key);
  return 0;
}
