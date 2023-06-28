//const Web3 = require('web3');
//const web3 = new Web3('<YOUR_ETHEREUM_PROVIDER>');

// Import the contract ABI
const contractABI = [
  // Paste the ABI of the CBE contract here
	{
		"constant": false,
		"inputs": [
			{
				"name": "hash",
				"type": "uint256"
			},
			{
				"name": "id",
				"type": "uint256"
			},
			{
				"name": "P_pub_x",
				"type": "uint256"
			},
			{
				"name": "P_pub_y",
				"type": "uint256"
			},
			{
				"name": "PU_x",
				"type": "uint256"
			},
			{
				"name": "PU_y",
				"type": "uint256"
			},
			{
				"name": "eU",
				"type": "uint256"
			},
			{
				"name": "Qu_x",
				"type": "uint256"
			},
			{
				"name": "Qu_y",
				"type": "uint256"
			}
		],
		"name": "CA_store",
		"outputs": [
			{
				"name": "",
				"type": "string"
			}
		],
		"payable": true,
		"stateMutability": "payable",
		"type": "function"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"name": "",
				"type": "uint256"
			},
			{
				"indexed": false,
				"name": "",
				"type": "uint256"
			},
			{
				"indexed": false,
				"name": "",
				"type": "uint256"
			},
			{
				"indexed": false,
				"name": "",
				"type": "uint256"
			},
			{
				"indexed": false,
				"name": "",
				"type": "uint256"
			},
			{
				"indexed": false,
				"name": "",
				"type": "uint256"
			},
			{
				"indexed": false,
				"name": "",
				"type": "uint256"
			},
			{
				"indexed": false,
				"name": "",
				"type": "uint256"
			}
		],
		"name": "storagelog",
		"type": "event"
	},
	{
		"constant": true,
		"inputs": [
			{
				"name": "hash",
				"type": "uint256"
			}
		],
		"name": "getQ",
		"outputs": [
			{
				"name": "",
				"type": "uint256"
			},
			{
				"name": "",
				"type": "uint256"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [
			{
				"name": "hash",
				"type": "uint256"
			}
		],
		"name": "verifier",
		"outputs": [
			{
				"name": "",
				"type": "string"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	}
];

// Specify the contract address
const contractAddress = '0xd8b934580fcE35a11B58C6D73aDeE468a2833fa8';

// Specify the number of transactions to simulate
const numTransactions = [1,2,5,10,20,50,100,200,300,400,500,600,700,800,900,1000];

// Specify the from account address
const fromAccount = '0x5B38Da6a701c568545dCfcB03FcB875f56beddC4';

for (let k = 0; k < numTransactions.length; k++) {

async function testContract() {
  let totalExecutionTime = 0;
  
  // Initialize the contract instance using Remix's web3 object
  const contractInstance = new web3.eth.Contract(contractABI, contractAddress);

  // Simulate multiple transactions
  for (let i = 0; i < numTransactions[k]; i++) {
    const hash = i + 1;
    const id = i + 1;
    const P_pub_x = 123; // Replace with actual values
    const P_pub_y = 456;
    const PU_x = 789;
    const PU_y = 987;
    const eU = 654;
    const Qu_x = 321;
    const Qu_y = 654;

    const startTime = Date.now();

    // Call the CA_store function with 'from' account
    await contractInstance.methods.CA_store(hash, id, P_pub_x, P_pub_y, PU_x, PU_y, eU, Qu_x, Qu_y).send({ from: fromAccount });

    const endTime = Date.now();
    const executionTime = endTime - startTime;
    totalExecutionTime += executionTime;

    //console.log(`Transaction ${i + 1}: ${executionTime} ms`);
  }

  const averageTime = totalExecutionTime / numTransactions[k];
  const throughput = numTransactions[k] / (totalExecutionTime / 1000); // Transactions per second

  console.log(`numTransactions: ${numTransactions[k]} Average Time: ${averageTime} ms,Throughput: ${throughput} TPS`);
  //console.log(`Throughput: ${throughput} TPS`);
}

testContract();

}