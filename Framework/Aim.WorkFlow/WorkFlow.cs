using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Serialization;
using System.IO;
using System.Xml;
using Aim.WorkFlow.WinService;
using Aim.Data;

namespace Aim.WorkFlow
{
    public class WorkFlow
    {
        private static WinService.FlowBusClient _client;

        public static WinService.FlowBusClient ServiceClient
        {
            get
            {
                if (_client == null)
                {
                    _client = new WinService.FlowBusClient();
                }

                return _client;
            }
        }
        /// <summary>
        /// 启动流程
        /// </summary>
        /// <param name="formUrl">表单URL全路径</param>
        /// <param name="title">任务标题,存放表单关键字等,以区分任务列表中的任务</param>
        /// <param name="flowDefineKey">流程定义Key</param>
        /// <param name="userId">第一环节执行人ID</param>
        /// <param name="userName">第一环节执行人</param>
        /// <returns>流程实例ID</returns>
        public static Guid StartWorkFlow(string formUrl, string flowDefineKey, string userId, string userName)
        {
            Guid guid = ServiceClient.StartFlow(Guid.Empty, formUrl, "", flowDefineKey, userId, userName);
            return guid;
        }
        /// <summary>
        /// 启动流程
        /// </summary>
        /// <param name="formId">表单实例ID</param>
        /// <param name="formUrl">表单URL全路径</param>
        /// <param name="flowDefineKey">流程定义Key</param>
        /// <param name="userId">第一环节执行人ID</param>
        /// <param name="userName">第一环节执行人</param>
        /// <returns>流程实例ID</returns>
        public static Guid StartWorkFlow(string formId, string formUrl, string flowDefineKey, string userId, string userName)
        {
            Guid guid = ServiceClient.StartFlow(new Guid(formId), formUrl, "", flowDefineKey, userId, userName);
            return guid;
        }
        /// <summary>
        /// 启动流程
        /// </summary>
        /// <param name="formId">表单实例ID</param>
        /// <param name="formUrl">表单URL全路径</param>
        /// <param name="title">任务标题,存放表单关键字等,以区分任务列表中的任务</param>
        /// <param name="flowDefineKey">流程定义Key</param>
        /// <param name="userId">第一环节执行人ID</param>
        /// <param name="userName">第一环节执行人</param>
        /// <returns>流程实例ID</returns>
        public static Guid StartWorkFlow(string formId, string formUrl, string title, string flowDefineKey, string userId, string userName)
        {
            if (formId.Trim() == "") formId = Guid.Empty.ToString();
            Guid guid = ServiceClient.StartFlow(new Guid(formId), formUrl, title, flowDefineKey, userId, userName);
            return guid;
        }

        /// <summary>
        /// 提交任务
        /// </summary>
        /// <param name="defineKey">流程定义Key</param>
        /// <param name="instanseId">流程实例ID</param>
        /// <param name="bookmarkName">任务bookmarkid</param>
        /// <param name="result">审批结果</param>
        public static void SubmitTask(string defineId, string instanseId, string bookmarkName, WinService.ApprovalResult result)
        {
            ServiceClient.SubmitApprovalResult(new Guid(instanseId), bookmarkName, result);
        }

        /// <summary>
        /// 适用于流程第二步已指定人员的,自动执行
        /// </summary>
        /// <param name="fTask"></param>
        public static void AutoExecute(Task fTask)
        {
            XmlSerializer xs = new XmlSerializer(typeof(TaskContext));
            if (!string.IsNullOrEmpty(fTask.Context))
            {
                StringReader sr = new StringReader(fTask.Context);
                TaskContext content = xs.Deserialize(sr) as TaskContext;
                if (content.SwitchRules.Length > 0)
                {
                    TaskContextSwitchRuleNextAction[] arrs = content.SwitchRules[0].NextActions;
                    if (arrs.Length > 0)
                    {
                        string route = arrs[0].Name;
                        Aim.WorkFlow.WinService.Task taskS = Aim.WorkFlow.WorkFlow.ServiceClient.GetTaskByTaskId(fTask.ID);
                        SubmitTask("", fTask.WorkflowInstanceID, fTask.BookmarkName, GetApprovalResult(taskS, fTask.ID, fTask.WorkflowInstanceID, route)); ;
                    }
                }
            }
        }
        /// <summary>
        /// 适用于流程第二步已指定人员的,自动执行
        /// </summary>
        /// <param name="fTask"></param>
        public static void AutoExecute(Task fTask, params string[] userIdsNames)
        {
            XmlSerializer xs = new XmlSerializer(typeof(TaskContext));
            if (!string.IsNullOrEmpty(fTask.Context))
            {
                StringReader sr = new StringReader(fTask.Context);
                TaskContext content = xs.Deserialize(sr) as TaskContext;
                if (content.SwitchRules.Length > 0)
                {
                    TaskContextSwitchRuleNextAction[] arrs = content.SwitchRules[0].NextActions;
                    if (arrs.Length > 0)
                    {
                        string route = arrs[0].Name;
                        Aim.WorkFlow.WinService.Task taskS = Aim.WorkFlow.WorkFlow.ServiceClient.GetTaskByTaskId(fTask.ID);
                        SubmitTask("", fTask.WorkflowInstanceID, fTask.BookmarkName, GetApprovalResult(taskS, fTask.ID, fTask.WorkflowInstanceID, route, userIdsNames)); ;
                    }
                }
            }
        }

        /// <summary>
        /// 适用于自动提交下一步并跳转,指定环节提交
        /// </summary>
        /// <param name="fTask">Task</param>
        /// <param name="NextNodeName">要跳转节点的名称</param>
        /// <param name="userIdsNames">跳转节点需要办理的人员</param>
        public static void AutoExecute(Task fTask, string NextNodeName, params string[] userIdsNames)
        {
            WinService.Task taskS = ServiceClient.GetTaskByTaskId(fTask.ID);
            SubmitTask("", fTask.WorkflowInstanceID, fTask.BookmarkName, GetApprovalResult(taskS, fTask.ID, fTask.WorkflowInstanceID, NextNodeName, userIdsNames));
        }

        public static ApprovalResult GetJumpResult(Aim.WorkFlow.WinService.Task task, string taskId, string winstanceId, string nextName, params string[] UserIdsNames)
        {
            ApprovalResult result = new ApprovalResult()
            {
                Task = task,
                TaskId = task.ID,

                ApprovalDateTime = DateTime.Now,

                Opinion = ApprovalOpinion.同意,
                ExtendedProperties = new List<KeyValuePair_V2>().ToArray(),
                ApprovalNodeSkipInfoList = new List<ApprovalNodeSkipInfo>().ToArray(),

                //Comment = ""
            };
            /// 设定选中的流转节点
            if (nextName != "")
            {
                result.SwitchRules = new KeyValuePair_V2[] 
                    { 
                        new KeyValuePair_V2() 
                        { 
                            Key = task.ApprovalNodeName, 
                            Value = nextName 
                        } 
                    };
                string nextNodeName = nextName;
                /// 设定指定流转节点的审批人员的信息. 
                List<ApprovalNodeContext> approvalNodeContexts = new List<ApprovalNodeContext>();
                ApprovalNodeContext specifiedApprovalNodeContext = new ApprovalNodeContext();
                specifiedApprovalNodeContext.Name = nextNodeName;

                if (UserIdsNames != null && UserIdsNames.Length == 2)
                {
                    LoadFromConfigString(specifiedApprovalNodeContext, UserIdsNames[0].TrimEnd(','), UserIdsNames[1].TrimEnd(','));
                    approvalNodeContexts.Add(specifiedApprovalNodeContext);
                    result.SpecifiedApprovalNodeContexts = approvalNodeContexts.ToArray();
                }
            }

            return result;
        }

        /// <summary>
        /// 获取下一环节角色或者人
        /// </summary>
        /// <param name="fTask">Aim.WorkFlow.Task</param>
        /// <param name="roleId">传入空</param>
        /// <param name="roleName"></param>
        /// <param name="roleType"></param>
        /// <param name="nextNodeName"></param>
        public static void GetNextRoles(Task fTask, ref string roleId, ref string roleName, ref string roleType, ref string nextNodeName)
        {
            XmlSerializer xs = new XmlSerializer(typeof(TaskContext));
            if (!string.IsNullOrEmpty(fTask.Context))
            {
                StringReader sr = new StringReader(fTask.Context);
                TaskContext content = xs.Deserialize(sr) as TaskContext;
                if (content.SwitchRules.Length > 0)
                {
                    TaskContextSwitchRuleNextAction[] arrs = content.SwitchRules[0].NextActions;
                    if (arrs.Length > 0)
                    {
                        string route = arrs[0].Name;
                        WorkflowInstance ins = WorkflowInstance.Find(fTask.WorkflowInstanceID);
                        //Aim.WorkFlow.WorkflowTemplate temp = Aim.WorkFlow.WorkflowTemplate.Find(ins.WorkflowTemplateID);
                        XmlDocument doc = new XmlDocument();
                        doc.LoadXml(ins.XAML);
                        XmlElement root = doc.DocumentElement;
                        string nameSpace = root.NamespaceURI;
                        XmlNamespaceManager nsmgr = new XmlNamespaceManager(doc.NameTable);
                        nsmgr.AddNamespace("ns", nameSpace);
                        nsmgr.AddNamespace("x", "http://schemas.microsoft.com/winfx/2006/xaml");
                        nsmgr.AddNamespace("bwa", "clr-namespace:BPM.WF.Activities;assembly=BPM.WF");

                        string current = "ApprovalNode Name=\"" + fTask.ApprovalNodeName + "\"";
                        XmlNode currentNode = root.SelectSingleNode("//*[contains(@ApprovalNodeConfig,'" + current + "')]", nsmgr);
                        //XmlNode node = root.SelectSingleNode("//*[@x:Key='" + nextName + "']", nsmgr);
                        XmlNode node = currentNode.NextSibling.SelectSingleNode("ns:FlowSwitch/ns:FlowStep[@x:Key='" + route + "']", nsmgr);
                        string contents = "ApprovalNode Name=\"" + route + "\"";
                        if (root.SelectSingleNode("//*[contains(@ApprovalNodeConfig,'" + contents + "')]", nsmgr) != null)//直接路由
                        {
                            string config = System.Web.HttpUtility.HtmlDecode(root.SelectSingleNode("//*[contains(@ApprovalNodeConfig,'" + contents + "')]", nsmgr).Attributes["ApprovalNodeConfig"].InnerXml);
                            XmlDocument docC = new XmlDocument();
                            docC.LoadXml(config);
                            nextNodeName = docC.DocumentElement.Attributes["Name"].InnerText.ToString();
                            if (docC.DocumentElement.SelectSingleNode("ApprovalUnits") != null && docC.DocumentElement.SelectSingleNode("ApprovalUnits").ChildNodes.Count > 0)
                            {
                                XmlNodeList list = docC.DocumentElement.SelectSingleNode("ApprovalUnits").ChildNodes;
                                foreach (XmlNode chd in list)
                                {
                                    roleId += chd.ChildNodes[0].Attributes["Value"].InnerText + ",";
                                    roleName += chd.ChildNodes[0].Attributes["Name"].InnerText + ",";
                                    roleType = chd.ChildNodes[0].Attributes["Type"].InnerText;
                                }
                            }
                        }
                    }
                }
            }

        }

        /// <summary>
        /// 获取下一节点名称及人员信息
        /// </summary>
        /// <param name="fTask">Aim.WorkFlow.Task 实体（根据task表ID获得）</param>
        /// <param name="nextNodeName">下一节点名称，引用类型</param>
        /// <param name="roleId">下一节点配置的人员、角色ID，引用类型</param>
        /// <param name="roleName">下一节点配置的人员、角色名称，引用类型</param>
        /// <param name="roleType">下一节点配置的类型，用于区别人员还是角色。值为ADAccount时是人员，其它表示角色</param>
        public static void GetNextNodeContents(Task fTask, ref string nextNodeName, ref string roleId, ref string roleName, ref string roleType)
        {
            XmlSerializer xs = new XmlSerializer(typeof(TaskContext));
            if (!string.IsNullOrEmpty(fTask.Context))
            {
                StringReader sr = new StringReader(fTask.Context);
                TaskContext content = xs.Deserialize(sr) as TaskContext;
                if (content.SwitchRules.Length > 0)
                {
                    TaskContextSwitchRuleNextAction[] arrs = content.SwitchRules[0].NextActions;
                    if (arrs.Length > 0)
                    {
                        string route = arrs[0].Name;
                        WorkflowInstance ins = WorkflowInstance.Find(fTask.WorkflowInstanceID);
                        //Aim.WorkFlow.WorkflowTemplate temp = Aim.WorkFlow.WorkflowTemplate.Find(ins.WorkflowTemplateID);
                        XmlDocument doc = new XmlDocument();
                        doc.LoadXml(ins.XAML);
                        XmlElement root = doc.DocumentElement;
                        string nameSpace = root.NamespaceURI;
                        XmlNamespaceManager nsmgr = new XmlNamespaceManager(doc.NameTable);
                        nsmgr.AddNamespace("ns", nameSpace);
                        nsmgr.AddNamespace("x", "http://schemas.microsoft.com/winfx/2006/xaml");
                        nsmgr.AddNamespace("bwa", "clr-namespace:BPM.WF.Activities;assembly=BPM.WF");

                        string current = "ApprovalNode Name=\"" + fTask.ApprovalNodeName + "\"";
                        XmlNode currentNode = root.SelectSingleNode("//*[contains(@ApprovalNodeConfig,'" + current + "')]", nsmgr);
                        //XmlNode node = root.SelectSingleNode("//*[@x:Key='" + nextName + "']", nsmgr);
                        XmlNode node = currentNode.NextSibling.SelectSingleNode("ns:FlowSwitch/ns:FlowStep[@x:Key='" + route + "']", nsmgr);
                        string contents = "ApprovalNode Name=\"" + route + "\"";
                        if (root.SelectSingleNode("//*[contains(@ApprovalNodeConfig,'" + contents + "')]", nsmgr) != null)//直接路由
                        {
                            string config = System.Web.HttpUtility.HtmlDecode(root.SelectSingleNode("//*[contains(@ApprovalNodeConfig,'" + contents + "')]", nsmgr).Attributes["ApprovalNodeConfig"].InnerXml);
                            XmlDocument docC = new XmlDocument();
                            docC.LoadXml(config);
                            nextNodeName = docC.DocumentElement.Attributes["Name"].InnerText.ToString();
                            if (docC.DocumentElement.SelectSingleNode("ApprovalUnits") != null && docC.DocumentElement.SelectSingleNode("ApprovalUnits").ChildNodes.Count > 0)
                            {
                                XmlNodeList list = docC.DocumentElement.SelectSingleNode("ApprovalUnits").ChildNodes;
                                foreach (XmlNode chd in list)
                                {
                                    roleId += chd.ChildNodes[0].Attributes["Value"].InnerText + ",";
                                    roleName += chd.ChildNodes[0].Attributes["Name"].InnerText + ",";
                                    roleType = chd.ChildNodes[0].Attributes["Type"].InnerText;
                                }
                            }
                        }
                    }
                }
            }
        }

        /// <summary>
        /// 获取下一节点名称及人员信息
        /// </summary>
        /// <param name="fTask">Aim.WorkFlow.Task 实体（根据task表ID获得）</param>
        /// <param name="route">下一环节多分支，需要传入分支条件（同意，不同意等其一）</param>
        /// <param name="nextNodeName">下一节点名称，引用类型</param>
        /// <param name="nextUserIds">下一节点配置的人员、角色ID，引用类型</param>
        /// <param name="nextUserNames">下一节点配置的人员、角色名称，引用类型</param>
        /// <param name="nextUserAccountType">下一节点配置的类型，用于区别人员还是角色。值为ADAccount时是人员，其它表示角色</param>
        public static void GetNextNodeContents(Task fTask, string route, ref string nextNodeName, ref string nextUserIds, ref string nextUserNames, ref string nextUserAccountType)
        {
            string instanctId = fTask.WorkflowInstanceID;
            Aim.WorkFlow.WorkflowInstance temp = Aim.WorkFlow.WorkflowInstance.Find(instanctId);
            XmlDocument doc = new XmlDocument();
            doc.LoadXml(temp.XAML);
            XmlElement root = doc.DocumentElement;
            string nameSpace = root.NamespaceURI;
            XmlNamespaceManager nsmgr = new XmlNamespaceManager(doc.NameTable);
            nsmgr.AddNamespace("ns", nameSpace);
            nsmgr.AddNamespace("x", "http://schemas.microsoft.com/winfx/2006/xaml");
            nsmgr.AddNamespace("bwa", "clr-namespace:BPM.WF.Activities;assembly=BPM.WF");

            string current = "ApprovalNode Name=\"" + fTask.ApprovalNodeName + "\"";
            XmlNode currentNode = root.SelectSingleNode("//*[contains(@ApprovalNodeConfig,'" + current + "')]", nsmgr);
            //XmlNode node = root.SelectSingleNode("//*[@x:Key='" + nextName + "']", nsmgr);
            XmlNode node = currentNode.NextSibling.SelectSingleNode("ns:FlowSwitch/ns:FlowStep[@x:Key='" + route + "']", nsmgr);
            string content = "ApprovalNode Name=\"" + route + "\"";
            if (node != null)//switch路由
            {
                node = node.SelectSingleNode("bwa:Approval_Node", nsmgr);
                if (node != null)
                {
                    string config = System.Web.HttpUtility.HtmlDecode(node.Attributes["ApprovalNodeConfig"].InnerXml);
                    SetNextUsers(config, ref nextUserIds, ref nextUserNames, ref nextUserAccountType, ref nextNodeName);
                }
            }
            //如果是打回的情况
            XmlNode nextNode = root.SelectSingleNode("//*[contains(@ApprovalNodeConfig,'" + route + "')]", nsmgr);
            if (currentNode.ParentNode.SelectSingleNode("ns:FlowStep.Next/ns:FlowSwitch/x:Reference/x:Key", nsmgr) != null)//switch情况的打回
            {
                if (currentNode.ParentNode.SelectSingleNode("ns:FlowStep.Next/ns:FlowSwitch/x:Reference[x:Key/text()='" + route + "']", nsmgr) != null)
                {
                    string reference = currentNode.ParentNode.SelectSingleNode("ns:FlowStep.Next/ns:FlowSwitch/x:Reference[x:Key/text()='" + route + "']", nsmgr).ChildNodes[0].InnerText;
                    nextNode = root.SelectSingleNode("//*[@x:Name='" + reference + "']", nsmgr);
                    string config = System.Web.HttpUtility.HtmlDecode(nextNode.SelectSingleNode("bwa:Approval_Node", nsmgr).Attributes["ApprovalNodeConfig"].InnerXml);
                    XmlDocument docC = new XmlDocument();
                    docC.LoadXml(config);
                    nextNodeName = docC.DocumentElement.Attributes["Name"].InnerText.ToString();
                    SetNextUsers(instanctId, nextNodeName, ref nextUserIds, ref nextUserNames, ref nextUserAccountType);
                }
            }
            nextNode = root.SelectSingleNode("//*[contains(@ApprovalNodeConfig,'" + route + "')]", nsmgr);
            if (currentNode.ParentNode.SelectSingleNode("ns:FlowStep.Next/ns:FlowSwitch/x:Reference/x:Key", nsmgr) != null)//switch情况的打回
            {
                if (currentNode.ParentNode.SelectSingleNode("ns:FlowStep.Next/ns:FlowSwitch/x:Reference[x:Key/text()='" + route + "']", nsmgr) != null)
                {
                    string reference = currentNode.ParentNode.SelectSingleNode("ns:FlowStep.Next/ns:FlowSwitch/x:Reference[x:Key/text()='" + route + "']", nsmgr).ChildNodes[0].InnerText;
                    nextNode = root.SelectSingleNode("//*[@x:Name='" + reference + "']", nsmgr);
                    string config = System.Web.HttpUtility.HtmlDecode(nextNode.SelectSingleNode("bwa:Approval_Node", nsmgr).Attributes["ApprovalNodeConfig"].InnerXml);
                    XmlDocument docC = new XmlDocument();
                    docC.LoadXml(config);
                    nextNodeName = docC.DocumentElement.Attributes["Name"].InnerText.ToString();
                    SetNextUsers(instanctId, nextNodeName, ref nextUserIds, ref nextUserNames, ref nextUserAccountType);
                }
            }
            else if (currentNode.SelectSingleNode("parent::*/ns:FlowStep.Next/x:Reference", nsmgr) != null)//正常路由打回
            {
                string refer = currentNode.SelectSingleNode("parent::*/ns:FlowStep.Next/x:Reference", nsmgr).InnerText;
                if (refer == nextNode.ParentNode.Attributes["x:Name"].Value)
                {
                    SetNextUsers(instanctId, route, ref nextUserIds, ref nextUserNames, ref nextUserAccountType);
                }
                nextNodeName = route;
            }

        }
        public static void SetNextUsers(string instanceId, string NodeName, ref string userIds, ref string userNames, ref string accountType)
        {
            Aim.WorkFlow.Task[] tks = Aim.WorkFlow.Task.FindAllByProperties(Aim.WorkFlow.Task.Prop_WorkflowInstanceID, instanceId, Aim.WorkFlow.Task.Prop_ApprovalNodeName, NodeName);
            foreach (Aim.WorkFlow.Task tk in tks)
            {
                if (userIds.IndexOf(tk.OwnerId) >= 0) continue;
                userIds += tk.OwnerId + ",";
                userNames += tk.Owner + ",";
                accountType = "ADAccount";
            }
        }
        public static void SetNextUsers(string config, ref string userIds, ref string userNames, ref string accountType, ref string nextNodeName)
        {
            XmlDocument docC = new XmlDocument();
            docC.LoadXml(config);
            nextNodeName = docC.DocumentElement.Attributes["Name"].InnerText.ToString();
            if (docC.DocumentElement.SelectSingleNode("ApprovalUnits") != null && docC.DocumentElement.SelectSingleNode("ApprovalUnits").ChildNodes.Count > 0)
            {
                XmlNodeList list = docC.DocumentElement.SelectSingleNode("ApprovalUnits").ChildNodes;
                foreach (XmlNode chd in list)
                {
                    userIds += chd.ChildNodes[0].Attributes["Value"].InnerText + ",";
                    userNames += chd.ChildNodes[0].Attributes["Name"].InnerText + ",";
                    accountType = chd.ChildNodes[0].Attributes["Type"].InnerText;
                }
            }
        }

        public static bool CheckNodeExsit(string instanctId, string nodeName)
        {
            Aim.WorkFlow.WorkflowInstance temp = Aim.WorkFlow.WorkflowInstance.Find(instanctId);
            XmlDocument doc = new XmlDocument();
            doc.LoadXml(temp.XAML);
            XmlElement root = doc.DocumentElement;
            string nameSpace = root.NamespaceURI;
            XmlNamespaceManager nsmgr = new XmlNamespaceManager(doc.NameTable);
            nsmgr.AddNamespace("ns", nameSpace);
            nsmgr.AddNamespace("x", "http://schemas.microsoft.com/winfx/2006/xaml");
            nsmgr.AddNamespace("bwa", "clr-namespace:BPM.WF.Activities;assembly=BPM.WF");

            string current = "ApprovalNode Name=\"" + nodeName + "\"";
            XmlNode currentNode = root.SelectSingleNode("//*[contains(@ApprovalNodeConfig,'" + current + "')]", nsmgr);
            if (currentNode != null)
                return true;
            return false;
        }
        /// <summary>
        /// 根据工作流定义Code判读是否存在节点
        /// </summary>
        /// <param name="code"></param>
        /// <param name="nodeName"></param>
        /// <returns></returns>
        public static bool CheckNodeExsitByCode(string code, string nodeName)
        {
            Aim.WorkFlow.WorkflowTemplate[] temp = Aim.WorkFlow.WorkflowTemplate.FindAllByProperty(WorkflowTemplate.Prop_Code, code);
            if (temp.Length == 0)
                return false;
            else
            {
                XmlDocument doc = new XmlDocument();
                doc.LoadXml(temp[0].XAML);
                XmlElement root = doc.DocumentElement;
                string nameSpace = root.NamespaceURI;
                XmlNamespaceManager nsmgr = new XmlNamespaceManager(doc.NameTable);
                nsmgr.AddNamespace("ns", nameSpace);
                nsmgr.AddNamespace("x", "http://schemas.microsoft.com/winfx/2006/xaml");
                nsmgr.AddNamespace("bwa", "clr-namespace:BPM.WF.Activities;assembly=BPM.WF");

                string current = "ApprovalNode Name=\"" + nodeName + "\"";
                XmlNode currentNode = root.SelectSingleNode("//*[contains(@ApprovalNodeConfig,'" + current + "')]", nsmgr);
                if (currentNode != null)
                    return true;
            }
            return false;
        }

        public static ApprovalResult GetApprovalResult(Aim.WorkFlow.WinService.Task task, string taskId, string winstanceId, string route, params string[] UserIdsNames)
        {
            ApprovalResult result = new ApprovalResult()
            {
                Task = task,
                TaskId = task.ID,

                ApprovalDateTime = DateTime.Now,

                Opinion = ApprovalOpinion.同意,
                ExtendedProperties = new List<KeyValuePair_V2>().ToArray(),
                ApprovalNodeSkipInfoList = new List<ApprovalNodeSkipInfo>().ToArray(),

                //Comment = ""
            };

            /// 设定跳过后续哪些节点. 
            /*List<ApprovalNodeSkipInfo> approvalNodeSkipInfos = new List<ApprovalNodeSkipInfo>();

            if (checkBox1.IsChecked.HasValue && checkBox1.IsChecked.Value)
                approvalNodeSkipInfos.Add(new ApprovalNodeSkipInfo() { ApprovalNodeContextName = "经理审批", CanBeSkipped = true });

            if (checkBox2.IsChecked.HasValue && checkBox2.IsChecked.Value)
                approvalNodeSkipInfos.Add(new ApprovalNodeSkipInfo() { ApprovalNodeContextName = "主管审批", CanBeSkipped = true });

            result.ApprovalNodeSkipInfoList = approvalNodeSkipInfos.ToArray();
            */
            /// 设定选中的流转节点
            if (route != "")
            {
                result.SwitchRules = new KeyValuePair_V2[] 
                    { 
                        new KeyValuePair_V2() 
                        { 
                            Key = task.ApprovalNodeName, 
                            Value = route 
                        } 
                    };
                WorkflowInstance ins = WorkflowInstance.Find(winstanceId);
                //Aim.WorkFlow.WorkflowTemplate temp = Aim.WorkFlow.WorkflowTemplate.Find(ins.WorkflowTemplateID);
                XmlDocument doc = new XmlDocument();
                doc.LoadXml(ins.XAML);
                XmlElement root = doc.DocumentElement;
                string nameSpace = root.NamespaceURI;
                XmlNamespaceManager nsmgr = new XmlNamespaceManager(doc.NameTable);
                nsmgr.AddNamespace("ns", nameSpace);
                nsmgr.AddNamespace("x", "http://schemas.microsoft.com/winfx/2006/xaml");
                nsmgr.AddNamespace("bwa", "clr-namespace:BPM.WF.Activities;assembly=BPM.WF");

                string current = "ApprovalNode Name=\"" + task.ApprovalNodeName + "\"";
                XmlNode currentNode = root.SelectSingleNode("//*[contains(@ApprovalNodeConfig,'" + current + "')]", nsmgr);
                //XmlNode node = root.SelectSingleNode("//*[@x:Key='" + nextName + "']", nsmgr);
                XmlNode node = currentNode.NextSibling.SelectSingleNode("ns:FlowSwitch/ns:FlowStep[@x:Key='" + route + "']", nsmgr);
                string nextUserIds = "";
                string nextUserNames = "";
                string nextUserAccountType = "";
                string nextNodeName = "";
                string content = "ApprovalNode Name=\"" + route + "\"";
                if (root.SelectSingleNode("//*[contains(@ApprovalNodeConfig,'" + content + "')]", nsmgr) != null)//直接路由
                {
                    string config = System.Web.HttpUtility.HtmlDecode(root.SelectSingleNode("//*[contains(@ApprovalNodeConfig,'" + content + "')]", nsmgr).Attributes["ApprovalNodeConfig"].InnerXml);
                    XmlDocument docC = new XmlDocument();
                    docC.LoadXml(config);
                    nextNodeName = docC.DocumentElement.Attributes["Name"].InnerText.ToString();
                    if (docC.DocumentElement.SelectSingleNode("ApprovalUnits") != null && docC.DocumentElement.SelectSingleNode("ApprovalUnits").ChildNodes.Count > 0)
                    {
                        XmlNodeList list = docC.DocumentElement.SelectSingleNode("ApprovalUnits").ChildNodes;
                        foreach (XmlNode chd in list)
                        {
                            nextUserIds += chd.ChildNodes[0].Attributes["Value"].InnerText + ",";
                            nextUserNames += chd.ChildNodes[0].Attributes["Name"].InnerText + ",";
                            nextUserAccountType = chd.ChildNodes[0].Attributes["Type"].InnerText;
                        }
                    }
                }
                nextUserIds = nextUserIds.TrimEnd(',');
                nextUserNames = nextUserNames.TrimEnd(',');
                /// 设定指定流转节点的审批人员的信息. 
                List<ApprovalNodeContext> approvalNodeContexts = new List<ApprovalNodeContext>();
                ApprovalNodeContext specifiedApprovalNodeContext = new ApprovalNodeContext();
                specifiedApprovalNodeContext.Name = nextNodeName;

                if (nextUserAccountType != "ADAccount" && nextUserIds != "" && UserIdsNames != null && UserIdsNames.Length == 0)//如果是组或者角色
                {
                    string[] grpIds = nextUserIds.Split(',');
                    string[] grpNames = nextUserNames.Split(',');
                    List<ApprovalUnitContext> approvalUnitContexts = new List<ApprovalUnitContext>();
                    foreach (string groupId in grpIds)
                    {
                        string cou = @"select count(*) from (select distinct ParentDeptName from View_SysUserGroup where ChildDeptName=(Select Name from SysRole where RoleID='{0}')) a";
                        string sql = "";
                        int count = DataHelper.QueryValue<int>(string.Format(cou, groupId));
                        IList<EasyDictionary> lists = null;
                        //判断角色的唯一性,多部门角色需要对应到部门
                        if (count > 1)
                        {
                            sql = @"select distinct UserID,UserName Name from View_SysUserGroup where ChildDeptName in (Select Name from SysRole where RoleID='{0}') 
                            and (select top 1 Path+'.'+DeptId from View_SysUserGroup where UserID='{1}') like '%'+Path+'%'";
                            sql = string.Format(sql, groupId, task.OwnerId);

                            lists = DataHelper.QueryDictList(sql);
                        }
                        else if (count == 1)
                        {
                            sql = "select UserId,UserName Name from View_SysUserGroup where ChildDeptName=(Select Name from SysRole where RoleID='{0}')";
                            sql = string.Format(sql, groupId);
                            lists = DataHelper.QueryDictList(sql);
                        }
                        if (lists == null || lists.Count == 0)
                        {
                            throw new Exception("缺少角色" + nextUserNames + "的人员!");
                        }
                        foreach (EasyDictionary ed in lists)
                        {
                            approvalUnitContexts.Add(new ApprovalUnitContext() { Approver = new Approver() { Value = ed["UserID"].ToString(), Name = ed["Name"].ToString() } });
                        }
                    }
                    specifiedApprovalNodeContext.ApprovalUnitContexts = approvalUnitContexts.ToArray();
                    approvalNodeContexts.Add(specifiedApprovalNodeContext);
                    result.SpecifiedApprovalNodeContexts = approvalNodeContexts.ToArray();
                }
                else if (UserIdsNames != null && UserIdsNames.Length == 2)
                {
                    LoadFromConfigString(specifiedApprovalNodeContext, UserIdsNames[0].TrimEnd(','), UserIdsNames[1].TrimEnd(','));
                    approvalNodeContexts.Add(specifiedApprovalNodeContext);
                    result.SpecifiedApprovalNodeContexts = approvalNodeContexts.ToArray();
                }
                else if (nextUserIds.Trim() != "")
                {
                    LoadFromConfigString(specifiedApprovalNodeContext, nextUserIds, nextUserNames);
                    approvalNodeContexts.Add(specifiedApprovalNodeContext);
                    result.SpecifiedApprovalNodeContexts = approvalNodeContexts.ToArray();
                }
                /*List<ApprovalNodeContext> approvalNodeContexts = new List<ApprovalNodeContext>();

                ApprovalNodeContext specifiedApprovalNodeContext = new ApprovalNodeContext();
                specifiedApprovalNodeContext.Name = this.RequestData["RouteName"].ToString();

                string userIds = this.RequestData["UserIds"].ToString().TrimEnd(',');
                string userNames = this.RequestData["UserNames"].ToString().TrimEnd(',');
                LoadFromConfigString(specifiedApprovalNodeContext, userIds,userNames);
                approvalNodeContexts.Add(specifiedApprovalNodeContext);
                result.SpecifiedApprovalNodeContexts = approvalNodeContexts.ToArray();*/
            }

            return result;
        }

        private static ApprovalNodeContext LoadFromConfigString(ApprovalNodeContext approvalNodeContext, string userIds, string userNames)
        {
            //TODO: 需要扩展, 将config扩展为更复杂的格式.

            string[] accounts = userIds.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
            string[] accountNames = userNames.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
            List<ApprovalUnitContext> approvalUnitContexts = new List<ApprovalUnitContext>();


            for (int i = 0; i < accounts.Length; i++)
                approvalUnitContexts.Add(new ApprovalUnitContext() { Approver = new Approver() { Value = accounts[i], Name = accountNames[i] } });

            approvalNodeContext.ApprovalUnitContexts = approvalUnitContexts.ToArray();


            return approvalNodeContext;
        }

        /// <summary>
        /// 获取下一节点名称及人员信息
        /// </summary>
        /// <param name="instanceId">工作流实例ID</param>
        /// <param name="fTask">当前环节名</param>
        /// <param name="nextNodeName">下一节点名称，引用类型</param>
        /// <param name="roleId">下一节点配置的人员、角色ID，引用类型</param>
        /// <param name="roleName">下一节点配置的人员、角色名称，引用类型</param>
        /// <param name="roleType">下一节点配置的类型，用于区别人员还是角色。值为ADAccount时是人员，其它表示角色</param>
        public static void GetNextNodeContentsByNodeName(string instanceId, string NodeName, ref string nextNodeName, ref string roleId, ref string roleName, ref string roleType)
        {
            WorkflowInstance ins = WorkflowInstance.Find(instanceId);
            //Aim.WorkFlow.WorkflowTemplate temp = Aim.WorkFlow.WorkflowTemplate.Find(ins.WorkflowTemplateID);
            XmlDocument doc = new XmlDocument();
            doc.LoadXml(ins.XAML);
            XmlElement root = doc.DocumentElement;
            string nameSpace = root.NamespaceURI;
            XmlNamespaceManager nsmgr = new XmlNamespaceManager(doc.NameTable);
            nsmgr.AddNamespace("ns", nameSpace);
            nsmgr.AddNamespace("x", "http://schemas.microsoft.com/winfx/2006/xaml");
            nsmgr.AddNamespace("bwa", "clr-namespace:BPM.WF.Activities;assembly=BPM.WF");

            string current = "ApprovalNode Name=\"" + NodeName + "\"";
            if (root.SelectSingleNode("//*[contains(@ApprovalNodeConfig,'" + current + "')]", nsmgr) != null)//直接路由
            {
                string config = System.Web.HttpUtility.HtmlDecode(root.SelectSingleNode("//*[contains(@ApprovalNodeConfig,'" + current + "')]", nsmgr).Attributes["ApprovalNodeConfig"].InnerXml);
                XmlDocument docC = new XmlDocument();
                docC.LoadXml(config);
                nextNodeName = docC.DocumentElement.Attributes["Name"].InnerText.ToString();
                if (docC.DocumentElement.SelectSingleNode("ApprovalUnits") != null && docC.DocumentElement.SelectSingleNode("ApprovalUnits").ChildNodes.Count > 0)
                {
                    XmlNodeList list = docC.DocumentElement.SelectSingleNode("ApprovalUnits").ChildNodes;
                    foreach (XmlNode chd in list)
                    {
                        roleId += chd.ChildNodes[0].Attributes["Value"].InnerText + ",";
                        roleName += chd.ChildNodes[0].Attributes["Name"].InnerText + ",";
                        roleType = chd.ChildNodes[0].Attributes["Type"].InnerText;
                    }
                }
            }
        }

        /// <summary>
        /// 获取下一节点名称及人员信息
        /// </summary>
        /// <param name="instanceId">工作流实例ID</param>
        /// <param name="fTask">当前环节名</param>
        /// <param name="route">下一环节多分支，需要传入分支条件（同意，不同意等其一）</param>
        /// <param name="nextNodeName">下一节点名称，引用类型</param>
        /// <param name="nextUserIds">下一节点配置的人员、角色ID，引用类型</param>
        /// <param name="nextUserNames">下一节点配置的人员、角色名称，引用类型</param>
        /// <param name="nextUserAccountType">下一节点配置的类型，用于区别人员还是角色。值为ADAccount时是人员，其它表示角色</param>
        public static void GetNextNodeContentsByName(string instanceId, string currentName, string route, ref string nextNodeName, ref string nextUserIds, ref string nextUserNames, ref string nextUserAccountType)
        {
            Aim.WorkFlow.WorkflowInstance temp = Aim.WorkFlow.WorkflowInstance.Find(instanceId);
            XmlDocument doc = new XmlDocument();
            doc.LoadXml(temp.XAML);
            XmlElement root = doc.DocumentElement;
            string nameSpace = root.NamespaceURI;
            XmlNamespaceManager nsmgr = new XmlNamespaceManager(doc.NameTable);
            nsmgr.AddNamespace("ns", nameSpace);
            nsmgr.AddNamespace("x", "http://schemas.microsoft.com/winfx/2006/xaml");
            nsmgr.AddNamespace("bwa", "clr-namespace:BPM.WF.Activities;assembly=BPM.WF");

            string current = "ApprovalNode Name=\"" + currentName + "\"";
            XmlNode currentNode = root.SelectSingleNode("//*[contains(@ApprovalNodeConfig,'" + current + "')]", nsmgr);
            //XmlNode node = root.SelectSingleNode("//*[@x:Key='" + nextName + "']", nsmgr);
            XmlNode node = currentNode.NextSibling.SelectSingleNode("ns:FlowSwitch/ns:FlowStep[@x:Key='" + route + "']", nsmgr);
            string content = "ApprovalNode Name=\"" + route + "\"";
            if (node != null)//switch路由
            {
                node = node.SelectSingleNode("bwa:Approval_Node", nsmgr);
                if (node != null)
                {
                    string config = System.Web.HttpUtility.HtmlDecode(node.Attributes["ApprovalNodeConfig"].InnerXml);
                    SetNextUsers(config, ref nextUserIds, ref nextUserNames, ref nextUserAccountType, ref nextNodeName);
                }
            }
            //如果是打回的情况
            XmlNode nextNode = root.SelectSingleNode("//*[contains(@ApprovalNodeConfig,'" + route + "')]", nsmgr);
            if (currentNode.ParentNode.SelectSingleNode("ns:FlowStep.Next/ns:FlowSwitch/x:Reference/x:Key", nsmgr) != null)//switch情况的打回
            {
                if (currentNode.ParentNode.SelectSingleNode("ns:FlowStep.Next/ns:FlowSwitch/x:Reference[x:Key/text()='" + route + "']", nsmgr) != null)
                {
                    string reference = currentNode.ParentNode.SelectSingleNode("ns:FlowStep.Next/ns:FlowSwitch/x:Reference[x:Key/text()='" + route + "']", nsmgr).ChildNodes[0].InnerText;
                    nextNode = root.SelectSingleNode("//*[@x:Name='" + reference + "']", nsmgr);
                    string config = System.Web.HttpUtility.HtmlDecode(nextNode.SelectSingleNode("bwa:Approval_Node", nsmgr).Attributes["ApprovalNodeConfig"].InnerXml);
                    XmlDocument docC = new XmlDocument();
                    docC.LoadXml(config);
                    nextNodeName = docC.DocumentElement.Attributes["Name"].InnerText.ToString();
                    SetNextUsers(instanceId, nextNodeName, ref nextUserIds, ref nextUserNames, ref nextUserAccountType);
                }
            }
            nextNode = root.SelectSingleNode("//*[contains(@ApprovalNodeConfig,'" + route + "')]", nsmgr);
            if (currentNode.ParentNode.SelectSingleNode("ns:FlowStep.Next/ns:FlowSwitch/x:Reference/x:Key", nsmgr) != null)//switch情况的打回
            {
                if (currentNode.ParentNode.SelectSingleNode("ns:FlowStep.Next/ns:FlowSwitch/x:Reference[x:Key/text()='" + route + "']", nsmgr) != null)
                {
                    string reference = currentNode.ParentNode.SelectSingleNode("ns:FlowStep.Next/ns:FlowSwitch/x:Reference[x:Key/text()='" + route + "']", nsmgr).ChildNodes[0].InnerText;
                    nextNode = root.SelectSingleNode("//*[@x:Name='" + reference + "']", nsmgr);
                    string config = System.Web.HttpUtility.HtmlDecode(nextNode.SelectSingleNode("bwa:Approval_Node", nsmgr).Attributes["ApprovalNodeConfig"].InnerXml);
                    XmlDocument docC = new XmlDocument();
                    docC.LoadXml(config);
                    nextNodeName = docC.DocumentElement.Attributes["Name"].InnerText.ToString();
                    SetNextUsers(instanceId, nextNodeName, ref nextUserIds, ref nextUserNames, ref nextUserAccountType);
                }
            }
            else if (currentNode.SelectSingleNode("parent::*/ns:FlowStep.Next/x:Reference", nsmgr) != null)//正常路由打回
            {
                string refer = currentNode.SelectSingleNode("parent::*/ns:FlowStep.Next/x:Reference", nsmgr).InnerText;
                if (refer == nextNode.ParentNode.Attributes["x:Name"].Value)
                {
                    SetNextUsers(instanceId, route, ref nextUserIds, ref nextUserNames, ref nextUserAccountType);
                }
                nextNodeName = route;
            }

        }
    }



    //------------------------------------------------------------------------------
    // <auto-generated>
    //     This code was generated by a tool.
    //     Runtime Version:4.0.30319.1
    //
    //     Changes to this file may cause incorrect behavior and will be lost if
    //     the code is regenerated.
    // </auto-generated>
    //------------------------------------------------------------------------------


    // 
    // This source code was auto-generated by xsd, Version=4.0.30319.1.
    // 


    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(AnonymousType = true)]
    [System.Xml.Serialization.XmlRootAttribute(Namespace = "", IsNullable = false)]
    public partial class TaskContext
    {

        private TaskContextSwitchRule[] switchRulesField;

        /// <remarks/>
        [System.Xml.Serialization.XmlArrayAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified)]
        [System.Xml.Serialization.XmlArrayItemAttribute("SwitchRule", Form = System.Xml.Schema.XmlSchemaForm.Unqualified, IsNullable = false)]
        public TaskContextSwitchRule[] SwitchRules
        {
            get
            {
                return this.switchRulesField;
            }
            set
            {
                this.switchRulesField = value;
            }
        }
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(AnonymousType = true)]
    public partial class TaskContextSwitchRule
    {

        private TaskContextSwitchRuleNextAction[] nextActionsField;

        private string nodeNameField;

        /// <remarks/>
        [System.Xml.Serialization.XmlArrayAttribute(Form = System.Xml.Schema.XmlSchemaForm.Unqualified)]
        [System.Xml.Serialization.XmlArrayItemAttribute("NextAction", Form = System.Xml.Schema.XmlSchemaForm.Unqualified, IsNullable = false)]
        public TaskContextSwitchRuleNextAction[] NextActions
        {
            get
            {
                return this.nextActionsField;
            }
            set
            {
                this.nextActionsField = value;
            }
        }

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string NodeName
        {
            get
            {
                return this.nodeNameField;
            }
            set
            {
                this.nodeNameField = value;
            }
        }
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("xsd", "4.0.30319.1")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(AnonymousType = true)]
    public partial class TaskContextSwitchRuleNextAction
    {

        private string nameField;

        /// <remarks/>
        [System.Xml.Serialization.XmlAttributeAttribute()]
        public string Name
        {
            get
            {
                return this.nameField;
            }
            set
            {
                this.nameField = value;
            }
        }
    }
}
