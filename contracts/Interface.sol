pragma solidity ^0.4.18;

import "./Agreements.sol";
    
contract Interface {
    
    struct Borrower {
        uint age;
        string fName;
        string lName;
        uint creditRating;
        uint term;
        uint amount;
        string pan;
        string purpose;
        string phoneNumber;
        string email;
        string aadhar;
        string city;
        string company;
        
        bool created;
        
    }
    
    struct Lender {
        string fname;
        string lname;
        string email;
        string pan;
        string aadhar;
        bool created;
        int rating;
    }
    
    struct P2PPortal {
        string name;
    }
    
    struct CIC{
        string name;
    }
    
    struct RequestBorrowerDetail{
        address lender;
        address borrower;
        bool borrowerAccepted;
    }
    
    
    mapping (address => Lender) private lenders;
    mapping (address => Borrower) private borrowers;
    mapping (address => mapping(address=>RequestBorrowerDetail)) private detailRequests;
    
    
    address[] private lenderActs;
    address[] private borrowerActs;
    RequestBorrowerDetail[] private totalRequests;
    
    function RequestBorrowerDetails(address borrower) public {
        var detailRequest = detailRequests[borrower][msg.sender];
        detailRequest.lender = msg.sender;
        detailRequest.borrower = borrower;
        detailRequest.borrowerAccepted = false;
        totalRequests.push(detailRequest) -1;
    }
    
    function getTotalRequests() view public returns(uint){
        return totalRequests.length;
    }
    
    function getRequestDetail(address borrower, address lender) view public returns(address, address, bool){
        var req =  detailRequests[borrower][lender];
        return (req.borrower, req.lender, req.borrowerAccepted);
    }
    
    function AcceptDetailRequest(address lender) public {
        var detailRequest = detailRequests[msg.sender][lender];
        detailRequest.borrowerAccepted = true;
    }
    
    function createAgreement(address lender, address borrower, uint term, uint amount, uint interest) public {
        var agreement = new Agreements(borrower, lender, msg.sender, term, amount, interest);
    }
    
    function createLender(string _fname, string _lname, string _email, string _pan, string _aadhar) public{
        var lender = lenders[msg.sender];
        if (lender.created == true)
            revert();
        
        lender.fname = _fname;
        lender.lname = _lname;
        lender.email = _email;
        lender.pan = _pan;
        lender.aadhar = _aadhar;
        lender.created = true;
        
        lenderActs.push(msg.sender) -1;
        
    }
    
    
    function setBorrower(uint _age, string _fName, string _lName, uint _creditRating, uint _term, uint _amount, string _pan, string _purpose, string _phoneNumber, string _aadhar, string _city, string _company) public {
        var borrower = borrowers[msg.sender];
        
        if(borrower.created == true)
            revert();
        
        borrower.age = _age;
        borrower.fName = _fName;
        borrower.lName = _lName;
        borrower.creditRating = _creditRating;
        borrower.term = _term;
        borrower.amount = _amount;
        borrower.purpose = _purpose;
        borrower.phoneNumber = _phoneNumber;
        borrower.aadhar = _aadhar;
        borrower.city = _city;
        borrower.company = _company;
        borrower.pan = _pan;

        borrower.created = true;
        
        borrowerActs.push(msg.sender) -1;
    }

    function getBorrowers() view public returns(address[]) {
        return borrowerActs;
    }
    
    function getLenders() view public returns(address[]){
        return lenderActs;
    }
    
    function getLenderDetails(address _lender) view public returns(string,string){
        var lender = lenders[_lender];
        return (lender.fname, lender.lname);
    }
    
    function getBorrowerShort(address _address) view public returns (string, string, uint, uint, uint, string) {
        return (borrowers[_address].fName, borrowers[_address].lName, borrowers[_address].creditRating, borrowers[_address].term, borrowers[_address].amount, borrowers[_address].purpose);
    }
    
    function getBorrowerFull(address _address) view public returns(string, string, uint, uint, uint, string, string){
        if (detailRequests[_address][msg.sender].borrowerAccepted == false)
            revert();
        return (borrowers[_address].fName , borrowers[_address].lName, borrowers[_address].creditRating, borrowers[_address].term, borrowers[_address].amount, borrowers[_address].aadhar, borrowers[_address].pan);
    }
    
    function countBorrowers() view public returns (uint) {
        return borrowerActs.length;
    }
    
}


