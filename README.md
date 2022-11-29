# WisdomProtocol
WisdomProtocol is a Protocol of wisdom sdk. 

Function Description:
1. WisdomProtocol sdk: Support compatible syntax 'Swift/objective-c' protocol usage.

2. WisdomProtocol sdk: Support sdk across 'module/project/static library/dynamic library' internal 'Class/UIViewController/UIView/Param' routing protocol.

3. WisdomProtocol sdk: Support data types 'dictionary/json/model/model collection' to 'encoding/decoding' conversion protocol.
   - 'Set class/data' to 'encoding/decoding' task, in the Debug environment, conversion failure, added the assertion processing, easy to debug phase, immediately discover data hidden dangers:
     * assert(able != nil, "decodable failure: \(value)") *
     * assert(dict != nil, "decodable failure: \(able)") *
     
4. WisdomProtocol sdk: Support object enablement 'objective-c/Swift Class' timer 'forward/countdown' task protocol. 
   - Timer life cycle/release does not require the user's concern, the use of timers is maintained/managed automatically within the WisdomProtocol sdk.





# WisdomProtocol
WisdomProtocol是一个智能的协议 sdk。

功能描述:
1. WisdomProtocol sdk: 支持兼容语法 'Swift/objective-c' 协议使用。

2. WisdomProtocol sdk: 支持sdk跨越 '模块/项目/静态库/动态库' 内部 'Class/UIViewController/UIView/Param' 路由协议。

3. WisdomProtocol sdk: 支持数据类型 '字典/字典数组/json/模型/模型数组' 的 '编码/解码' 转换协议。
  - '集合 类/数据' 的 '编码/解码' 任务，在调试环境下，转换失败，添加了断言处理，便于调试阶段，立即发现数据隐患：
    * assert(able != nil, "decodable failure: \(value)") *
    * assert(dict != nil, "decodable failure: \(able)") *

4. WisdomProtocol sdk: 支持对象启用 'objective-c/Swift Class' 定时器 '前进计时/倒计时' 任务协议。
   - 计时器的 生命周期/释放时机 不需要用户关注，计时器的使用在 WisdomProtocol sdk内部，会自动 管理/维护。
