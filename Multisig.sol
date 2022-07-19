pragma solidity 0.7.5;
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
        owners.push(msg.sender);

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
    }
    
    //Should return all transfer requests
    function getTransferRequests() public view returns (Transfer[] memory){
    }
    
    
}
