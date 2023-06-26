const TrieNode = require('./TrieNode');

class Trie {
    constructor() {
        const root = new TrieNode(null);
        this.root = root;
    }

    insert(word, index = 0, node = this.root) {
        if (index === word.length) {
            node.isWord = true;
            return;
        }

        const currentChar = word[index];
        if(!node.children[currentChar]) {
            node.children[currentChar] = new TrieNode(currentChar);
        }
        index = index + 1;

        return this.insert(word, index, node.children[currentChar]);
    }

    contains(word, index = 0, node = this.root) {
        if (index === word.length) {
            return node.isWord;
        }

        const currentChar = word[index];
        if(!node.children[currentChar]) {
            return false;
        }
        index = index + 1;

        return this.contains(word, index, node.children[currentChar]);
    }
}

module.exports = Trie;