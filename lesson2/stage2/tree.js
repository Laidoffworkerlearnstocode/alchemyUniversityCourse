function addNodeRecursive(parentNode, node){
    if (node.data < parentNode.data){
        if (parentNode.left === null){
            parentNode.left = node;
        } else {
            addNodeRecursive(parentNode.left, node);
        }
    }
    if (node.data > parentNode.data){
        if (parentNode.right === null){
            parentNode.right = node;
        } else {
            addNodeRecursive(parentNode.right, node);
        }
    }
}

function hasNodeRecursive(parentNode, value){
    if (parentNode === null){
        return false;
    } else if (parentNode.data === value){
        return true;
    } else if (value < parentNode.data){
        return hasNodeRecursive(parentNode.left, value);
    } else if (value > parentNode.data){
        return hasNodeRecursive(parentNode.right, value);
    }
}

class Tree {
    constructor() {
        this.root = null; 
    }
    addNode(node){
        if (this.root === null){
            this.root = node;
        } else {
            addNodeRecursive(this.root, node)
        }
    }
    hasNode(value){
        return hasNodeRecursive(this.root, value);
    }
}

module.exports = Tree;