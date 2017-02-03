// Business class QuestionItem generated from QuestionItems
// Creator: Ray
// Created Date: [2013-02-24]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;

namespace IntegratedManage.Model
{
    [ActiveRecord("QuestionItems")]
    public partial class QuestionItem : IMModelBase<QuestionItem>
    {
        #region Property_Names

        public static string Prop_Id = "Id";
        public static string Prop_SurveyQuestionId = "SurveyQuestionId";
        public static string Prop_QuestionContentId = "QuestionContentId";
        public static string Prop_QuestionContent = "QuestionContent";
        public static string Prop_IsExplanation = "IsExplanation";
        public static string Prop_Answer = "Answer";
        public static string Prop_SortIndex = "SortIndex";

        #endregion

        #region Private_Variables

        private string _id;
        private string _surveyQuestionId;
        private string _questionContentId;
        private string _questionContent;
        private string _isExplanation;
        private string _answer;
        private int? _sortIndex;


        #endregion

        #region Constructors

        public QuestionItem()
        {
        }

        public QuestionItem(
            string p_id,
            string p_surveyQuestionId,
            string p_questionContentId,
            string p_questionContent,
            string p_isExplanation,
            string p_answer,
            int? p_sortIndex)
        {
            _id = p_id;
            _surveyQuestionId = p_surveyQuestionId;
            _questionContentId = p_questionContentId;
            _questionContent = p_questionContent;
            _isExplanation = p_isExplanation;
            _answer = p_answer;
            _sortIndex = p_sortIndex;
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
                    RaisePropertyChanged(QuestionItem.Prop_SurveyQuestionId, oldValue, value);
                }
            }

        }

        [Property("QuestionContentId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
        public string QuestionContentId
        {
            get { return _questionContentId; }
            set
            {
                if ((_questionContentId == null) || (value == null) || (!value.Equals(_questionContentId)))
                {
                    object oldValue = _questionContentId;
                    _questionContentId = value;
                    RaisePropertyChanged(QuestionItem.Prop_QuestionContentId, oldValue, value);
                }
            }

        }

        [Property("QuestionContent", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 2000)]
        public string QuestionContent
        {
            get { return _questionContent; }
            set
            {
                if ((_questionContent == null) || (value == null) || (!value.Equals(_questionContent)))
                {
                    object oldValue = _questionContent;
                    _questionContent = value;
                    RaisePropertyChanged(QuestionItem.Prop_QuestionContent, oldValue, value);
                }
            }

        }

        [Property("IsExplanation", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 10)]
        public string IsExplanation
        {
            get { return _isExplanation; }
            set
            {
                if ((_isExplanation == null) || (value == null) || (!value.Equals(_isExplanation)))
                {
                    object oldValue = _isExplanation;
                    _isExplanation = value;
                    RaisePropertyChanged(QuestionItem.Prop_IsExplanation, oldValue, value);
                }
            }

        }

        [Property("Answer", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 2000)]
        public string Answer
        {
            get { return _answer; }
            set
            {
                if ((_answer == null) || (value == null) || (!value.Equals(_answer)))
                {
                    object oldValue = _answer;
                    _answer = value;
                    RaisePropertyChanged(QuestionItem.Prop_Answer, oldValue, value);
                }
            }

        }

        [Property("SortIndex", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
        public int? SortIndex
        {
            get { return _sortIndex; }
            set
            {
                if (value != _sortIndex)
                {
                    object oldValue = _sortIndex;
                    _sortIndex = value;
                    RaisePropertyChanged(QuestionItem.Prop_SortIndex, oldValue, value);
                }
            }

        }

        #endregion
    } // QuestionItem
}

