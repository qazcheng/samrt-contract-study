// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.4.21;
pragma experimental ABIEncoderV2;

contract RolePermissionBySol{

   //状态变量：用于存储合约创建者和角色权限
    address private _owner;
    mapping(address => mapping (uint => uint)) private _permission;

    //事件：用于跟踪监听对角色权限的修改
    event setPermissionEvent(address studentId, uint RoleID, uint PermissionID);

    //修饰器：用于对函数的操作权限验证
    modifier onlyOwner {
        require (_owner == msg.sender, "Auth: only owner is authorized. ");
        _;
    }

    //构造方法：用于初始化合约
    constructor () public {
        _owner = msg.sender;
    }
    
    //函数：用于新增/修改角色权限
    function setPermission (address studentId, uint RoleID, uint PermissionID) public onlyOwner returns (bool) {
        _permission[studentId][RoleID] = PermissionID;
        emit setPermissionEvent(studentId, RoleID, PermissionID) ;
        return true;
    }

    //函数：用于角色id查询权限id
    function getPermission (uint RoleID) public view returns (uint) {
        return _permission[msg.sender][RoleID];
    }

    mapping (address => uint) public balanceOf;
 
    function setBlance(address _address, uint RoleID) public returns (uint) {
        balanceOf[_address] = _permission[msg.sender][RoleID];
        return balanceOf[_address];
    }

}


contract Evidence{
    uint CODE_SUCCESS = 0;
    uint FILE_NOT_EXIST = 3002;
    uint FILE_ALREADY_EXIST  = 3003;
    uint USER_NOT_EXIST = 3004;
    // 定义数据结构体  
    struct FileEvidence{
    string fileHash;   //文件哈希  
    string author;   //文件作者
    string time;  //文件时间
    string fileName;       //论文名
    }
 
    mapping(string => FileEvidence) filemap;

    // 定义事件 
    event updateInfo(string fileHash, string author, string fileName,string time);


    address[] userList;
    
    function saveEvidence(string memory fileHash,string memory author, string memory fileName,string memory time) public returns(uint code){
        //get filemap under sender
        FileEvidence storage fileEvidence = filemap[fileName];
        fileEvidence.fileHash = fileHash;
        fileEvidence.author = author;
        fileEvidence.time = time;
        fileEvidence.fileName = fileName;
        // filemap[fileHash] = fileEvidence;
        // emit updateInfo(fileEvidence.fileHash,fileEvidence.fileUploadTime,fileEvidence.owner);
        return CODE_SUCCESS;
    }

    mapping (address => uint) public tmp;
    RolePermissionBySol rolePermissionBySol;

    //function ControlContract(address _rolePermissionBySolAddr) public {
        //rolePermissionBySol = RolePermissionBySol(_rolePermissionBySolAddr);
    //}

     //0x0b7fc2e3E23D3c85c6A4E3DBd45e2c1ac803cD09
    //function getEvidence(string memory fileName, uint RoleID)  public returns(uint)
    function getEvidence(address _rolePermissionBySolAddr, uint RoleID)  public returns(uint) {
        //get filemap under sender
        //rolePermissionBySol.setBlance(_rolePermissionBySolAddr, RoleID);
        rolePermissionBySol = RolePermissionBySol(_rolePermissionBySolAddr);
        tmp[_rolePermissionBySolAddr] = rolePermissionBySol.setBlance(msg.sender, RoleID);
        //FileEvidence memory fileEvidence = filemap[fileName];
        return tmp[_rolePermissionBySolAddr];
    }

}