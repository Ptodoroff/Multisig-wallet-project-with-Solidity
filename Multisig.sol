pragma solidity ^0.8.0;
pragma abicoder v2;

contract Wallet {
    address[] public owners;
    uint limit;
    
    struct Transfer{
        uint amount;
        address payable receiver;
        uint approvals;
        bool hasBeenSent;
        uint id;
    }
    
    Transfer[] transferRequests;
    
    mapping(address => mapping(uint => bool)) approvals;
    
    modifier onlyOwners(){
         bool owner=false;
         for (uint i; i<owners.length;++i){
            if (owners[i]==msg.sender){
                owner=true;
            }
         }
         require (owner==true);
         _;
        
        }


    
    constructor(address[] memory _owners, uint _limit) {
        owners=_owners;
        limit=_limit;
    }
    
    function deposit() public payable {}
    
    function createTransfer(uint _amount, address payable _receiver) public onlyOwners {
       transferRequests.push( Transfer(_amount,_receiver,0, false,transferRequests.length));
        
    }
    function approve(uint _id) public onlyOwners {
        require (approvals[msg.sender][_id]==false);
        require (transferRequests[_id].hasBeenSent==false);
        approvals[msg.sender][_id] = true;
        transferRequests[_id].approvals++;

        if(transferRequests[_id].approvals>=limit){
            transferRequests[_id].hasBeenSent==true;
            transferRequests[_id].receiver.transfer(transferRequests[_id].amount);
        }
    }
    
    //Should return all transfer requests
    function getTransferRequests() public view returns (Transfer[] memory){
        return transferRequests;
    }
    
        function getBalance () public returns (uint) {
        return address(this).balance;

    }
    
    
}
