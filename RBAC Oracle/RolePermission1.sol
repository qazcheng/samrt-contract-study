pragma solidity >=0.6.10 <0.8.20;
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
}

//0xfbbe31cb73d23ae79771157c2bb7c45cce7c1e18
//bytes32:0x626c756500000000000000000000000000000000000000000000000000000000