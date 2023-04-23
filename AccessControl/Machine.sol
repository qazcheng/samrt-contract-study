pragma solidity ^0.5.8;
pragma experimental ABIEncoderV2;
import "./Storage.sol";
import "./Calculator.sol";
contract Machine {
    
    address public user;

    string public fileHash;

    uint256 public PermissionID;
    
    Storage public s;

    Calculator public c;
  
    event GetPer_idByR_idByDelegateCall(uint256 R_id, bool success);

    event table_addByDelegateCall(uint256 R_id, uint256 Per_id, bool success);

    
    constructor(Storage addr1, Calculator addr2) public {
        s = addr1;
        c = addr2;
        //PermissionID = 0;
    }
    
    //function saveEvidence(string memory fileHash,string memory author, string memory fileName,string memory time) public returns (bool) {
    //    s.saveEvidence(fileHash,author,fileName,time);
    //    return true;
    //}
    function getEvidence(string memory fileName) public view returns (string memory) {
        return s.getEvidence(fileName);
    }

    function getPer_idByR_id(uint256 R_id) public returns(uint256){
        return c.getPer_idByR_id(R_id);
    }
    
    function getPer_idByR_idWithDelegateCall(address calculator, uint256 R_id) public returns (uint256) {
        (bool success, bytes memory result) = calculator.delegatecall(abi.encodeWithSignature("getPer_idByR_id(uint256)", R_id));
        emit GetPer_idByR_idByDelegateCall(R_id, success);
        return abi.decode(result, (uint256));
    }

    function Table_addWithDelegateCall(address calculator, uint256 R_id, uint256 Per_id) public returns (bool) {
        (bool success, bytes memory result) = calculator.delegatecall(abi.encodeWithSignature("Table_add(uint256,uint256)", R_id,Per_id));
        emit table_addByDelegateCall(R_id, Per_id, success);
        return abi.decode(result, (bool));
    }



    function query(string memory fileName, uint256 R_id) public returns (bool){
        fileHash = s.getEvidence(fileName);
        PermissionID = c.getPer_idByR_id(R_id);
        return true;
    }
}