contract Agreements {
     
    
       address private lender;
        address private borrower;
        address private p2p;
        uint private term;
        uint private amount;
        uint private interest;
        
        function Agreements(address _borrower, address _lender, address _p2p, uint _term, uint _amount, uint _interest) public {
            lender = _lender;
            borrower = _borrower;
            p2p = _p2p;
            term = _term;
            amount = _amount;
            interest = _interest;
        }
        
}


