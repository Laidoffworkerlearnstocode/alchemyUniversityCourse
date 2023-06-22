class Transaction {
    constructor(inputUTXOs, outputUTXOs) {
        this.inputUTXOs = inputUTXOs;
        this.outputUTXOs = outputUTXOs;
    }
    execute() {
        const spentInputUtxo = this.inputUTXOs.find(utxo => utxo.spent === true);
        const inputAmount = this.inputUTXOs.reduce((acc, utxo) => acc + utxo.amount, 0);
        const outputAmount = this.outputUTXOs.reduce((acc, utxo) => acc + utxo.amount, 0);
        const minerFee = inputAmount - outputAmount;

        if (spentInputUtxo) {
            throw new Error('There are one or more spent input UTXOs');
        } else if (inputAmount < outputAmount) {
            throw new Error('Input amount is less than output amount');
        } else {
            this.inputUTXOs.forEach(utxo => utxo.spent = true);
            this.fee = minerFee;
        }   
    }
}

module.exports = Transaction;