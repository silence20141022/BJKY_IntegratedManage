// Business class News generated from News
// Creator: Ray
// Created Date: [2013-05-24]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;

namespace Aim.Portal.Model
{
    [ActiveRecord("News")]
    public partial class News : EntityBase<News>
    {
        #region Property_Names

        public static string Prop_Id = "Id";
        public static string Prop_TypeId = "TypeId";
        public static string Prop_BelongDeptId = "BelongDeptId";
        public static string Prop_Title = "Title";
        public static string Prop_KeyWord = "KeyWord";
        public static string Prop_Content = "Content";
        public static string Prop_ContentType = "ContentType";
        public static string Prop_AuthorName = "AuthorName";
        public static string Prop_PostUserId = "PostUserId";
        public static string Prop_PostUserName = "PostUserName";
        public static string Prop_PostDeptId = "PostDeptId";
        public static string Prop_PostDeptName = "PostDeptName";
        public static string Prop_ReceiveDeptId = "ReceiveDeptId";
        public static string Prop_ReceiveDeptName = "ReceiveDeptName";
        public static string Prop_ReceiveUserId = "ReceiveUserId";
        public static string Prop_ReceiveUserName = "ReceiveUserName";
        public static string Prop_PostTime = "PostTime";
        public static string Prop_ExpireTime = "ExpireTime";
        public static string Prop_SaveTime = "SaveTime";
        public static string Prop_Pictures = "Pictures";
        public static string Prop_Attachments = "Attachments";
        public static string Prop_MHT = "MHT";
        public static string Prop_State = "State";
        public static string Prop_ImportantGrade = "ImportantGrade";
        public static string Prop_ReadCount = "ReadCount";
        public static string Prop_HomePagePopup = "HomePagePopup";
        public static string Prop_LinkPortalImage = "LinkPortalImage";
        public static string Prop_Class = "Class";
        public static string Prop_PopupIds = "PopupIds";
        public static string Prop_Grade = "Grade";
        public static string Prop_AuthorId = "AuthorId";
        public static string Prop_CreateTime = "CreateTime";
        public static string Prop_CreateId = "CreateId";
        public static string Prop_CreateName = "CreateName";
        public static string Prop_Type = "Type";
        public static string Prop_ReleaseState = "ReleaseState";
        public static string Prop_PId = "PId";
        public static string Prop_SubmitState = "SubmitState";
        public static string Prop_NewType = "NewType";
        public static string Prop_ReadState = "ReadState";
        public static string Prop_RemindDays = "RemindDays";
        public static string Prop_RdoType = "RdoType";
        public static string Prop_FileType = "FileType";
        public static string Prop_MhtFile = "MhtFile";
        public static string Prop_AuditUserId = "AuditUserId";
        public static string Prop_AuditUserName = "AuditUserName";
        public static string Prop_WFState = "WFState";
        public static string Prop_WFResult = "WFResult";
        public static string Prop_WFCurrentNode = "WFCurrentNode";
        public static string Prop_SecondApproveId = "SecondApproveId";
        public static string Prop_SecondApproveName = "SecondApproveName";

        #endregion

        #region Private_Variables

        private string _id;
        private string _typeId;
        private string _belongDeptId;
        private string _title;
        private string _keyWord;
        private string _content;
        private string _contentType;
        private string _authorName;
        private string _postUserId;
        private string _postUserName;
        private string _postDeptId;
        private string _postDeptName;
        private string _receiveDeptId;
        private string _receiveDeptName;
        private string _receiveUserId;
        private string _receiveUserName;
        private DateTime? _postTime;
        private DateTime? _expireTime;
        private DateTime? _saveTime;
        private string _pictures;
        private string _attachments;
        private string _mHT;
        private string _state;
        private string _importantGrade;
        private int? _readCount;
        private string _homePagePopup;
        private string _linkPortalImage;
        private string _class;
        private string _popupIds;
        private string _grade;
        private string _authorId;
        private DateTime? _createTime;
        private string _createId;
        private string _createName;
        private string _type;
        private string _releaseState;
        private string _pId;
        private string _submitState;
        private string _newType;
        private string _readState;
        private int? _remindDays;
        private string _rdoType;
        private string _fileType;
        private string _mhtFile;
        private string _auditUserId;
        private string _auditUserName;
        private string _wFState;
        private string _wFResult;
        private string _wFCurrentNode;
        private string _secondApproveId;
        private string _secondApproveName;

        #endregion

        #region Constructors

        public News()
        {
        }

        public News(
            string p_id,
            string p_typeId,
            string p_belongDeptId,
            string p_title,
            string p_keyWord,
            string p_content,
            string p_contentType,
            string p_authorName,
            string p_postUserId,
            string p_postUserName,
            string p_postDeptId,
            string p_postDeptName,
            string p_receiveDeptId,
            string p_receiveDeptName,
            string p_receiveUserId,
            string p_receiveUserName,
            DateTime? p_postTime,
            DateTime? p_expireTime,
            DateTime? p_saveTime,
            string p_pictures,
            string p_attachments,
            string p_mHT,
            string p_state,
            string p_importantGrade,
            int? p_readCount,
            string p_homePagePopup,
            string p_linkPortalImage,
            string p_class,
            string p_popupIds,
            string p_grade,
            string p_authorId,
            DateTime? p_createTime,
            string p_createId,
            string p_createName,
            string p_type,
            string p_releaseState,
            string p_pId,
            string p_submitState,
            string p_newType,
            string p_readState,
            int? p_remindDays,
            string p_rdoType,
            string p_fileType,
            string p_mhtFile,
            string p_auditUserId,
            string p_auditUserName,
            string p_wFState,
            string p_wFResult,
            string p_wFCurrentNode,
            string p_secondApproveId,
            string p_secondApproveName)
        {
            _id = p_id;
            _typeId = p_typeId;
            _belongDeptId = p_belongDeptId;
            _title = p_title;
            _keyWord = p_keyWord;
            _content = p_content;
            _contentType = p_contentType;
            _authorName = p_authorName;
            _postUserId = p_postUserId;
            _postUserName = p_postUserName;
            _postDeptId = p_postDeptId;
            _postDeptName = p_postDeptName;
            _receiveDeptId = p_receiveDeptId;
            _receiveDeptName = p_receiveDeptName;
            _receiveUserId = p_receiveUserId;
            _receiveUserName = p_receiveUserName;
            _postTime = p_postTime;
            _expireTime = p_expireTime;
            _saveTime = p_saveTime;
            _pictures = p_pictures;
            _attachments = p_attachments;
            _mHT = p_mHT;
            _state = p_state;
            _importantGrade = p_importantGrade;
            _readCount = p_readCount;
            _homePagePopup = p_homePagePopup;
            _linkPortalImage = p_linkPortalImage;
            _class = p_class;
            _popupIds = p_popupIds;
            _grade = p_grade;
            _authorId = p_authorId;
            _createTime = p_createTime;
            _createId = p_createId;
            _createName = p_createName;
            _type = p_type;
            _releaseState = p_releaseState;
            _pId = p_pId;
            _submitState = p_submitState;
            _newType = p_newType;
            _readState = p_readState;
            _remindDays = p_remindDays;
            _rdoType = p_rdoType;
            _fileType = p_fileType;
            _mhtFile = p_mhtFile;
            _auditUserId = p_auditUserId;
            _auditUserName = p_auditUserName;
            _wFState = p_wFState;
            _wFResult = p_wFResult;
            _wFCurrentNode = p_wFCurrentNode;
            _secondApproveId = p_secondApproveId;
            _secondApproveName = p_secondApproveName;
        }

        #endregion

        #region Properties

        [PrimaryKey("Id", Generator = PrimaryKeyType.Custom, CustomGenerator = typeof(AimIdentifierGenerator), Access = PropertyAccess.NosetterLowercaseUnderscore)]
        public string Id
        {
            get { return _id; }
            set { _id = value; } // 处理列表编辑时去掉注释

        }

        [Property("TypeId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
        public string TypeId
        {
            get { return _typeId; }
            set
            {
                if ((_typeId == null) || (value == null) || (!value.Equals(_typeId)))
                {
                    object oldValue = _typeId;
                    _typeId = value;
                    RaisePropertyChanged(News.Prop_TypeId, oldValue, value);
                }
            }

        }

        [Property("BelongDeptId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 200)]
        public string BelongDeptId
        {
            get { return _belongDeptId; }
            set
            {
                if ((_belongDeptId == null) || (value == null) || (!value.Equals(_belongDeptId)))
                {
                    object oldValue = _belongDeptId;
                    _belongDeptId = value;
                    RaisePropertyChanged(News.Prop_BelongDeptId, oldValue, value);
                }
            }

        }

        [Property("Title", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 500)]
        public string Title
        {
            get { return _title; }
            set
            {
                if ((_title == null) || (value == null) || (!value.Equals(_title)))
                {
                    object oldValue = _title;
                    _title = value;
                    RaisePropertyChanged(News.Prop_Title, oldValue, value);
                }
            }

        }

        [Property("KeyWord", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 500)]
        public string KeyWord
        {
            get { return _keyWord; }
            set
            {
                if ((_keyWord == null) || (value == null) || (!value.Equals(_keyWord)))
                {
                    object oldValue = _keyWord;
                    _keyWord = value;
                    RaisePropertyChanged(News.Prop_KeyWord, oldValue, value);
                }
            }

        }

        [Property("Content", Access = PropertyAccess.NosetterCamelcaseUnderscore, ColumnType = "StringClob")]
        public string Content
        {
            get { return _content; }
            set
            {
                if ((_content == null) || (value == null) || (!value.Equals(_content)))
                {
                    object oldValue = _content;
                    _content = value;
                    RaisePropertyChanged(News.Prop_Content, oldValue, value);
                }
            }

        }

        [Property("ContentType", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
        public string ContentType
        {
            get { return _contentType; }
            set
            {
                if ((_contentType == null) || (value == null) || (!value.Equals(_contentType)))
                {
                    object oldValue = _contentType;
                    _contentType = value;
                    RaisePropertyChanged(News.Prop_ContentType, oldValue, value);
                }
            }

        }

        [Property("AuthorName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
        public string AuthorName
        {
            get { return _authorName; }
            set
            {
                if ((_authorName == null) || (value == null) || (!value.Equals(_authorName)))
                {
                    object oldValue = _authorName;
                    _authorName = value;
                    RaisePropertyChanged(News.Prop_AuthorName, oldValue, value);
                }
            }

        }

        [Property("PostUserId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
        public string PostUserId
        {
            get { return _postUserId; }
            set
            {
                if ((_postUserId == null) || (value == null) || (!value.Equals(_postUserId)))
                {
                    object oldValue = _postUserId;
                    _postUserId = value;
                    RaisePropertyChanged(News.Prop_PostUserId, oldValue, value);
                }
            }

        }

        [Property("PostUserName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
        public string PostUserName
        {
            get { return _postUserName; }
            set
            {
                if ((_postUserName == null) || (value == null) || (!value.Equals(_postUserName)))
                {
                    object oldValue = _postUserName;
                    _postUserName = value;
                    RaisePropertyChanged(News.Prop_PostUserName, oldValue, value);
                }
            }

        }

        [Property("PostDeptId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 2000)]
        public string PostDeptId
        {
            get { return _postDeptId; }
            set
            {
                if ((_postDeptId == null) || (value == null) || (!value.Equals(_postDeptId)))
                {
                    object oldValue = _postDeptId;
                    _postDeptId = value;
                    RaisePropertyChanged(News.Prop_PostDeptId, oldValue, value);
                }
            }

        }

        [Property("PostDeptName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 2000)]
        public string PostDeptName
        {
            get { return _postDeptName; }
            set
            {
                if ((_postDeptName == null) || (value == null) || (!value.Equals(_postDeptName)))
                {
                    object oldValue = _postDeptName;
                    _postDeptName = value;
                    RaisePropertyChanged(News.Prop_PostDeptName, oldValue, value);
                }
            }

        }

        [Property("ReceiveDeptId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 2000)]
        public string ReceiveDeptId
        {
            get { return _receiveDeptId; }
            set
            {
                if ((_receiveDeptId == null) || (value == null) || (!value.Equals(_receiveDeptId)))
                {
                    object oldValue = _receiveDeptId;
                    _receiveDeptId = value;
                    RaisePropertyChanged(News.Prop_ReceiveDeptId, oldValue, value);
                }
            }

        }

        [Property("ReceiveDeptName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 2000)]
        public string ReceiveDeptName
        {
            get { return _receiveDeptName; }
            set
            {
                if ((_receiveDeptName == null) || (value == null) || (!value.Equals(_receiveDeptName)))
                {
                    object oldValue = _receiveDeptName;
                    _receiveDeptName = value;
                    RaisePropertyChanged(News.Prop_ReceiveDeptName, oldValue, value);
                }
            }

        }

        [Property("ReceiveUserId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 2000)]
        public string ReceiveUserId
        {
            get { return _receiveUserId; }
            set
            {
                if ((_receiveUserId == null) || (value == null) || (!value.Equals(_receiveUserId)))
                {
                    object oldValue = _receiveUserId;
                    _receiveUserId = value;
                    RaisePropertyChanged(News.Prop_ReceiveUserId, oldValue, value);
                }
            }

        }

        [Property("ReceiveUserName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 2000)]
        public string ReceiveUserName
        {
            get { return _receiveUserName; }
            set
            {
                if ((_receiveUserName == null) || (value == null) || (!value.Equals(_receiveUserName)))
                {
                    object oldValue = _receiveUserName;
                    _receiveUserName = value;
                    RaisePropertyChanged(News.Prop_ReceiveUserName, oldValue, value);
                }
            }

        }

        [Property("PostTime", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
        public DateTime? PostTime
        {
            get { return _postTime; }
            set
            {
                if (value != _postTime)
                {
                    object oldValue = _postTime;
                    _postTime = value;
                    RaisePropertyChanged(News.Prop_PostTime, oldValue, value);
                }
            }

        }

        [Property("ExpireTime", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
        public DateTime? ExpireTime
        {
            get { return _expireTime; }
            set
            {
                if (value != _expireTime)
                {
                    object oldValue = _expireTime;
                    _expireTime = value;
                    RaisePropertyChanged(News.Prop_ExpireTime, oldValue, value);
                }
            }

        }

        [Property("SaveTime", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
        public DateTime? SaveTime
        {
            get { return _saveTime; }
            set
            {
                if (value != _saveTime)
                {
                    object oldValue = _saveTime;
                    _saveTime = value;
                    RaisePropertyChanged(News.Prop_SaveTime, oldValue, value);
                }
            }

        }

        [Property("Pictures", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 2000)]
        public string Pictures
        {
            get { return _pictures; }
            set
            {
                if ((_pictures == null) || (value == null) || (!value.Equals(_pictures)))
                {
                    object oldValue = _pictures;
                    _pictures = value;
                    RaisePropertyChanged(News.Prop_Pictures, oldValue, value);
                }
            }

        }

        [Property("Attachments", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 2000)]
        public string Attachments
        {
            get { return _attachments; }
            set
            {
                if ((_attachments == null) || (value == null) || (!value.Equals(_attachments)))
                {
                    object oldValue = _attachments;
                    _attachments = value;
                    RaisePropertyChanged(News.Prop_Attachments, oldValue, value);
                }
            }

        }

        [Property("MHT", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 100)]
        public string MHT
        {
            get { return _mHT; }
            set
            {
                if ((_mHT == null) || (value == null) || (!value.Equals(_mHT)))
                {
                    object oldValue = _mHT;
                    _mHT = value;
                    RaisePropertyChanged(News.Prop_MHT, oldValue, value);
                }
            }

        }

        [Property("State", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 20)]
        public string State
        {
            get { return _state; }
            set
            {
                if ((_state == null) || (value == null) || (!value.Equals(_state)))
                {
                    object oldValue = _state;
                    _state = value;
                    RaisePropertyChanged(News.Prop_State, oldValue, value);
                }
            }

        }

        [Property("ImportantGrade", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 20)]
        public string ImportantGrade
        {
            get { return _importantGrade; }
            set
            {
                if ((_importantGrade == null) || (value == null) || (!value.Equals(_importantGrade)))
                {
                    object oldValue = _importantGrade;
                    _importantGrade = value;
                    RaisePropertyChanged(News.Prop_ImportantGrade, oldValue, value);
                }
            }

        }

        [Property("ReadCount", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
        public int? ReadCount
        {
            get { return _readCount; }
            set
            {
                if (value != _readCount)
                {
                    object oldValue = _readCount;
                    _readCount = value;
                    RaisePropertyChanged(News.Prop_ReadCount, oldValue, value);
                }
            }

        }

        [Property("HomePagePopup", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 10)]
        public string HomePagePopup
        {
            get { return _homePagePopup; }
            set
            {
                if ((_homePagePopup == null) || (value == null) || (!value.Equals(_homePagePopup)))
                {
                    object oldValue = _homePagePopup;
                    _homePagePopup = value;
                    RaisePropertyChanged(News.Prop_HomePagePopup, oldValue, value);
                }
            }

        }

        [Property("LinkPortalImage", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
        public string LinkPortalImage
        {
            get { return _linkPortalImage; }
            set
            {
                if ((_linkPortalImage == null) || (value == null) || (!value.Equals(_linkPortalImage)))
                {
                    object oldValue = _linkPortalImage;
                    _linkPortalImage = value;
                    RaisePropertyChanged(News.Prop_LinkPortalImage, oldValue, value);
                }
            }

        }

        [Property("Class", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 100)]
        public string Class
        {
            get { return _class; }
            set
            {
                if ((_class == null) || (value == null) || (!value.Equals(_class)))
                {
                    object oldValue = _class;
                    _class = value;
                    RaisePropertyChanged(News.Prop_Class, oldValue, value);
                }
            }

        }

        [Property("PopupIds", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 2000)]
        public string PopupIds
        {
            get { return _popupIds; }
            set
            {
                if ((_popupIds == null) || (value == null) || (!value.Equals(_popupIds)))
                {
                    object oldValue = _popupIds;
                    _popupIds = value;
                    RaisePropertyChanged(News.Prop_PopupIds, oldValue, value);
                }
            }

        }

        [Property("Grade", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
        public string Grade
        {
            get { return _grade; }
            set
            {
                if ((_grade == null) || (value == null) || (!value.Equals(_grade)))
                {
                    object oldValue = _grade;
                    _grade = value;
                    RaisePropertyChanged(News.Prop_Grade, oldValue, value);
                }
            }

        }

        [Property("AuthorId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
        public string AuthorId
        {
            get { return _authorId; }
            set
            {
                if ((_authorId == null) || (value == null) || (!value.Equals(_authorId)))
                {
                    object oldValue = _authorId;
                    _authorId = value;
                    RaisePropertyChanged(News.Prop_AuthorId, oldValue, value);
                }
            }

        }

        [Property("CreateTime", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
        public DateTime? CreateTime
        {
            get { return _createTime; }
            set
            {
                if (value != _createTime)
                {
                    object oldValue = _createTime;
                    _createTime = value;
                    RaisePropertyChanged(News.Prop_CreateTime, oldValue, value);
                }
            }

        }

        [Property("CreateId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
        public string CreateId
        {
            get { return _createId; }
            set
            {
                if ((_createId == null) || (value == null) || (!value.Equals(_createId)))
                {
                    object oldValue = _createId;
                    _createId = value;
                    RaisePropertyChanged(News.Prop_CreateId, oldValue, value);
                }
            }

        }

        [Property("CreateName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
        public string CreateName
        {
            get { return _createName; }
            set
            {
                if ((_createName == null) || (value == null) || (!value.Equals(_createName)))
                {
                    object oldValue = _createName;
                    _createName = value;
                    RaisePropertyChanged(News.Prop_CreateName, oldValue, value);
                }
            }

        }

        [Property("Type", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
        public string Type
        {
            get { return _type; }
            set
            {
                if ((_type == null) || (value == null) || (!value.Equals(_type)))
                {
                    object oldValue = _type;
                    _type = value;
                    RaisePropertyChanged(News.Prop_Type, oldValue, value);
                }
            }

        }

        [Property("ReleaseState", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 10)]
        public string ReleaseState
        {
            get { return _releaseState; }
            set
            {
                if ((_releaseState == null) || (value == null) || (!value.Equals(_releaseState)))
                {
                    object oldValue = _releaseState;
                    _releaseState = value;
                    RaisePropertyChanged(News.Prop_ReleaseState, oldValue, value);
                }
            }

        }

        [Property("PId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 10)]
        public string PId
        {
            get { return _pId; }
            set
            {
                if ((_pId == null) || (value == null) || (!value.Equals(_pId)))
                {
                    object oldValue = _pId;
                    _pId = value;
                    RaisePropertyChanged(News.Prop_PId, oldValue, value);
                }
            }

        }

        [Property("SubmitState", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 10)]
        public string SubmitState
        {
            get { return _submitState; }
            set
            {
                if ((_submitState == null) || (value == null) || (!value.Equals(_submitState)))
                {
                    object oldValue = _submitState;
                    _submitState = value;
                    RaisePropertyChanged(News.Prop_SubmitState, oldValue, value);
                }
            }

        }

        [Property("NewType", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 10)]
        public string NewType
        {
            get { return _newType; }
            set
            {
                if ((_newType == null) || (value == null) || (!value.Equals(_newType)))
                {
                    object oldValue = _newType;
                    _newType = value;
                    RaisePropertyChanged(News.Prop_NewType, oldValue, value);
                }
            }

        }

        [Property("ReadState", Access = PropertyAccess.NosetterCamelcaseUnderscore, ColumnType = "StringClob")]
        public string ReadState
        {
            get { return _readState; }
            set
            {
                if ((_readState == null) || (value == null) || (!value.Equals(_readState)))
                {
                    object oldValue = _readState;
                    _readState = value;
                    RaisePropertyChanged(News.Prop_ReadState, oldValue, value);
                }
            }

        }

        [Property("RemindDays", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
        public int? RemindDays
        {
            get { return _remindDays; }
            set
            {
                if (value != _remindDays)
                {
                    object oldValue = _remindDays;
                    _remindDays = value;
                    RaisePropertyChanged(News.Prop_RemindDays, oldValue, value);
                }
            }

        }

        [Property("RdoType", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 20)]
        public string RdoType
        {
            get { return _rdoType; }
            set
            {
                if ((_rdoType == null) || (value == null) || (!value.Equals(_rdoType)))
                {
                    object oldValue = _rdoType;
                    _rdoType = value;
                    RaisePropertyChanged(News.Prop_RdoType, oldValue, value);
                }
            }

        }

        [Property("FileType", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 30)]
        public string FileType
        {
            get { return _fileType; }
            set
            {
                if ((_fileType == null) || (value == null) || (!value.Equals(_fileType)))
                {
                    object oldValue = _fileType;
                    _fileType = value;
                    RaisePropertyChanged(News.Prop_FileType, oldValue, value);
                }
            }

        }

        [Property("MhtFile", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 200)]
        public string MhtFile
        {
            get { return _mhtFile; }
            set
            {
                if ((_mhtFile == null) || (value == null) || (!value.Equals(_mhtFile)))
                {
                    object oldValue = _mhtFile;
                    _mhtFile = value;
                    RaisePropertyChanged(News.Prop_MhtFile, oldValue, value);
                }
            }

        }

        [Property("AuditUserId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 1000)]
        public string AuditUserId
        {
            get { return _auditUserId; }
            set
            {
                if ((_auditUserId == null) || (value == null) || (!value.Equals(_auditUserId)))
                {
                    object oldValue = _auditUserId;
                    _auditUserId = value;
                    RaisePropertyChanged(News.Prop_AuditUserId, oldValue, value);
                }
            }
        }

        [Property("AuditUserName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 500)]
        public string AuditUserName
        {
            get { return _auditUserName; }
            set
            {
                if ((_auditUserName == null) || (value == null) || (!value.Equals(_auditUserName)))
                {
                    object oldValue = _auditUserName;
                    _auditUserName = value;
                    RaisePropertyChanged(News.Prop_AuditUserName, oldValue, value);
                }
            }
        }

        [Property("WFState", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 30)]
        public string WFState
        {
            get { return _wFState; }
            set
            {
                if ((_wFState == null) || (value == null) || (!value.Equals(_wFState)))
                {
                    object oldValue = _wFState;
                    _wFState = value;
                    RaisePropertyChanged(News.Prop_WFState, oldValue, value);
                }
            }
        }

        [Property("WFResult", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 30)]
        public string WFResult
        {
            get { return _wFResult; }
            set
            {
                if ((_wFResult == null) || (value == null) || (!value.Equals(_wFResult)))
                {
                    object oldValue = _wFResult;
                    _wFResult = value;
                    RaisePropertyChanged(News.Prop_WFResult, oldValue, value);
                }
            }
        }

        [Property("WFCurrentNode", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 30)]
        public string WFCurrentNode
        {
            get { return _wFCurrentNode; }
            set
            {
                if ((_wFCurrentNode == null) || (value == null) || (!value.Equals(_wFCurrentNode)))
                {
                    object oldValue = _wFCurrentNode;
                    _wFCurrentNode = value;
                    RaisePropertyChanged(News.Prop_WFCurrentNode, oldValue, value);
                }
            }
        }
        [Property("SecondApproveId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 1000)]
        public string SecondApproveId
        {
            get { return _secondApproveId; }
            set
            {
                if ((_secondApproveId == null) || (value == null) || (!value.Equals(_secondApproveId)))
                {
                    object oldValue = _secondApproveId;
                    _secondApproveId = value;
                    RaisePropertyChanged(News.Prop_SecondApproveId, oldValue, value);
                }
            }
        }

        [Property("SecondApproveName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 500)]
        public string SecondApproveName
        {
            get { return _secondApproveName; }
            set
            {
                if ((_secondApproveName == null) || (value == null) || (!value.Equals(_secondApproveName)))
                {
                    object oldValue = _secondApproveName;
                    _secondApproveName = value;
                    RaisePropertyChanged(News.Prop_SecondApproveName, oldValue, value);
                }
            }
        }
        #endregion
    } // News
}

