pragma solidity ^0.4.11;
contract KidHope {
    struct Donator {
        address addr;
        uint amount;
    }
    struct SP {
        address addr;
        uint amount;
    }
    struct CharitableOrganization {
        address beneficiary;
        uint budget;
        uint received;
        uint allowed;
        string accountSheet;
    }
    address owner;
    uint creationDate;
    uint period;
    uint totalDonations;
    uint numCOs;
    uint numDonators;
    uint totalBudget;
    mapping (uint => CharitableOrganization) charitableOrganizations;
    mapping (uint => Donator) donators;
    
    // construtor
    function KidHope () public {
        owner = msg.sender;
        creationDate = now;
        period = 1;
    }
    function getTotalDonated() public view returns (uint) {
        return totalDonations;
    }
    function newEntity(address _beneficiary, uint _budget, string _accountSheet) public returns (uint cOID) {
        cOID = numCOs++;
        charitableOrganizations[cOID] = CharitableOrganization(_beneficiary, _budget, 0, 0, _accountSheet);
        totalBudget += _budget;
        return cOID;
    }
    function approve(uint cOID, uint value) public returns (bool success) {
        require(value >= totalDonations);
        charitableOrganizations[cOID].allowed += value;
        return true;
    }
    
    function allowance (uint cOID) public constant returns (uint _amount) {
        return charitableOrganizations[cOID].allowed;
    }
    function transferFrom(uint cOID, uint _tokens) public payable returns (bool success) {
        require(charitableOrganizations[cOID].allowed >= _tokens);
        charitableOrganizations[cOID].received += _tokens;
        charitableOrganizations[cOID].allowed -= _tokens;
        totalDonations -= _tokens;
        return true;
    }
    
    function spend (uint cOID, address _to) public payable returns (bool) {
        require(charitableOrganizations[cOID].received >= msg.value);
        charitableOrganizations[cOID].received -= msg.value;
        _to.transfer(msg.value);
        return true;
    }
    
    function contribute() public payable returns (bool success) {
        numDonators = numDonators++;
        donators[numDonators] = Donator(msg.sender, msg.value);
        totalDonations += msg.value;
        return true;
    }
    
    function distribute() public returns (bool success){
        require(creationDate - now > (1296000) * period);
        require(period <= 12);
        period ++;
        uint factor = totalBudget / totalDonations;
        if (factor > 1) 
            factor = 1;
        uint i = 0;
        while (i <= numCOs) {
        approve(i,charitableOrganizations[i].budget/12 * factor);
            }
            return true;
        }
}