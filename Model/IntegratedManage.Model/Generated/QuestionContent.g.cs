// Business class QuestionContent generated from QuestionContent
// Creator: Ray
// Created Date: [2013-02-25]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;

namespace IntegratedManage.Model
{
    [ActiveRecord("QuestionContent")]
    public partial class QuestionContent : IMModelBase<QuestionContent>
    {
        #region Property_Names

        public static string Prop_Id = "Id";
        public static string Prop_SurveyQuestionId = "SurveyQuestionId";
        public static string Prop_Content = "Content";
        public static string Prop_QuestionType = "QuestionType";
        public static string Prop_IsMustAnswer = "IsMustAnswer";
        public static string Prop_IsComment = "IsComment";
        public static string Prop_SortIndex = "SortIndex";
        public static string Prop_QuestionItems = "QuestionItems";
        public static string Prop_CreateTime = "CreateTime";

        #endregion

        #region Private_Variables

        private string _id;
        private string _surveyQuestionId;
        private string _content;
        private string _questionType;
        private string _isMustAnswer;
        private string _isComment;
        private int _sortIndex;
        private string _questionItems;
        private DateTime? _createTime;


        #endregion

        #region Constructors

        public QuestionContent()
        {
        }

        public QuestionContent(
            string p_id,
            string p_surveyQuestionId,
            string p_content,
            string p_questionType,
            string p_isMustAnswer,
            string p_isComment,
            int p_sortIndex,
            string p_questionItems,
            DateTime? p_createTime)
        {
            _id = p_id;
            _surveyQuestionId = p_surveyQuestionId;
            _content = p_content;
            _questionType = p_questionType;
            _isMustAnswer = p_isMustAnswer;
            _isComment = p_isComment;
            _sortIndex = p_sortIndex;
            _questionItems = p_questionItems;
            _createTime = p_createTime;
        }

        #endregion

        #region Properties

        [PrimaryKey("Id", Generator = PrimaryKeyType.Custom, CustomGenerator = typeof(AimIdentifierGenerator), Access = PropertyAccess.NosetterLowercaseUnderscore)]
        public string Id
        {
            get { return _id; }
            set { _id = value; } // 处理列表编辑时去掉注释

        }

        [Property("SurveyQuestionId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
        public string SurveyQuestionId
        {
            get { return _surveyQuestionId; }
            set
            {
                if ((_surveyQuestionId == null) || (value == null) || (!value.Equals(_surveyQuestionId)))
                {
                    object oldValue = _surveyQuestionId;
                    _surveyQuestionId = value;
                    RaisePropertyChanged(QuestionContent.Prop_SurveyQuestionId, oldValue, value);
                }
            }

        }

        [Property("Content", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 2000)]
        public string Content
        {
            get { return _content; }
            set
            {
                if ((_content == null) || (value == null) || (!value.Equals(_content)))
                {
                    object oldValue = _content;
                    _content = value;
                    RaisePropertyChanged(QuestionContent.Prop_Content, oldValue, value);
                }
            }

        }

        [Property("QuestionType", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
        public string QuestionType
        {
            get { return _questionType; }
            set
            {
                if ((_questionType == null) || (value == null) || (!value.Equals(_questionType)))
                {
                    object oldValue = _questionType;
                    _questionType = value;
                    RaisePropertyChanged(QuestionContent.Prop_QuestionType, oldValue, value);
                }
            }

        }

        [Property("IsMustAnswer", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
        public string IsMustAnswer
        {
            get { return _isMustAnswer; }
            set
            {
                if ((_isMustAnswer == null) || (value == null) || (!value.Equals(_isMustAnswer)))
                {
                    object oldValue = _isMustAnswer;
                    _isMustAnswer = value;
                    RaisePropertyChanged(QuestionContent.Prop_IsMustAnswer, oldValue, value);
                }
            }

        }

        [Property("IsComment", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
        public string IsComment
        {
            get { return _isComment; }
            set
            {
                if ((_isComment == null) || (value == null) || (!value.Equals(_isComment)))
                {
                    object oldValue = _isComment;
                    _isComment = value;
                    RaisePropertyChanged(QuestionContent.Prop_IsComment, oldValue, value);
                }
            }

        }

        [Property("SortIndex", Access = PropertyAccess.NosetterCamelcaseUnderscore, NotNull = true)]
        public int SortIndex
        {
            get { return _sortIndex; }
            set
            {
                if (value != _sortIndex)
                {
                    object oldValue = _sortIndex;
                    _sortIndex = value;
                    RaisePropertyChanged(QuestionContent.Prop_SortIndex, oldValue, value);
                }
            }

        }

        [Property("QuestionItems", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 2000)]
        public string QuestionItems
        {
            get { return _questionItems; }
            set
            {
                if ((_questionItems == null) || (value == null) || (!value.Equals(_questionItems)))
                {
                    object oldValue = _questionItems;
                    _questionItems = value;
                    RaisePropertyChanged(QuestionContent.Prop_QuestionItems, oldValue, value);
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
                    RaisePropertyChanged(QuestionContent.Prop_CreateTime, oldValue, value);
                }
            }

        }

        #endregion
    } // QuestionContent
}

