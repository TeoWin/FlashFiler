�
 TFRMCONFIGURETEST 0(  TPF0TfrmConfigureTestfrmConfigureTestLeft�Top� Width+HeightCaptionConfigure SQL TestColor	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style OldCreateOrderPositionpoMainFormCenterOnCreate
FormCreate	OnDestroyFormDestroyOnShowFormShowPixelsPerInch`
TextHeight TPageControlpcWizardLeft Top Width#Height� 
ActivePagetsResultInformationAlignalClientTabOrder  	TTabSheettsIntroductionCaptionIntroductionOnShowtsIntroductionShow TLabellblCheckoutLeftTop8Width� HeightCaption/Please check out the SQLTests.FF2 file from VSSFont.CharsetDEFAULT_CHARSET
Font.ColorclRedFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontVisible  TLabellblConfigureLeftTopPWidth� HeightCaption#You must configure this applicationFont.CharsetDEFAULT_CHARSET
Font.ColorclRedFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontVisible  	TCheckBoxedtSkipLeft Top� Width� HeightCaptionAlways skip this pageTabOrder   TMemomemIntroductionLeft TopWidth�HeightBorderStylebsNoneLines.StringsPThis wizard will walk you through the steps necessary to create a SQL test case. ParentColor	TabOrder   	TTabSheettsTestInformationCaptionTest Information
ImageIndexOnShowtsTestInformationShow TLabellblTestNameLeftTop$Width2HeightCaption	Test name  TLabellblDescriptionLeftTop:Width5HeightCaptionDescription  TLabel
lblIssueIDLeft� Top� Width#HeightCaptionIssue #  TLabellblDateLeftTop� WidthHeightCaptionDate  TLabellblRunCountLeft�Top� Width2HeightCaption	Run count  TLabel
lblOrderIDLeftTopWidth(HeightCaptionOrder ID  TLabellblCategoryLeft� TopWidth*HeightCaptionCategory  TLabellblMaxSourceReadsLeftTop� WidthTHeightCaptionMax source reads  TEditedtTestNameLefthTop Width�Height	MaxLengthdTabOrder  TMemoedtDescriptionLefthTop:Width�HeightITabOrder  TEdit
edtIssueIDLeft� Top� WidthAHeight	MaxLengthTabOrder  TEditedtDateLeft8Top� WidthYHeight	MaxLength
TabOrder  TEditedtRunCountLeft�Top� Width)Height	MaxLength
TabOrder  	TCheckBoxedtIgnoreTestLeftTop� WidthmHeight	AlignmenttaLeftJustifyCaptionIgnore testTabOrder  TEdit
edtOrderIDLefthTopWidth9Height	MaxLengthTabOrder   	TComboBoxedtCategoryLeft� TopWidth� HeightStylecsDropDownList
ItemHeightTabOrderOnChangeedtCategoryChangeItems.StringsSELECTINSERTUPDATEDELETE   TEditedtMaxSourceReadsLefthTop� Width)Height	MaxLength
TabOrder   	TTabSheettsQueryInformationCaptionSQL
ImageIndex TLabellblDatabasePathLeftTopWidthFHeightCaptionDatabase path  TLabellblSQLLeft� Top(WidthHeightCaptionSQL  TLabel
lblTimeoutLeftTop:Width&HeightCaptionTimeout  	TCheckBoxedtQRequestLiveLeftTop&WidthgHeight	AlignmenttaLeftJustifyBiDiModebdLeftToRightCaptionRequest liveParentBiDiModeTabOrder  TEditedtQPathLeft`TopWidthHeightTabOrder   TEditedtQTimeoutLeft`Top8Width9HeightTabOrderText10000  TMemoedtQSQLLeft� Top8WidthaHeight� 
ScrollBars
ssVerticalTabOrder  TButtonbtnConfigureFilterQueryLeftTopXWidth� HeightCaptionConfigure FilterTabOrderOnClickbtnConfigureFilterQueryClick  TButton	pbExtractLefthTopWidthiHeightHintKExtracts the existing archive for this test to the specified database path.Caption&Extract to diskTabOrderOnClickpbExtractClick   	TTabSheettsCompareAgainstCaptionSQLExec - Additional
ImageIndex TLabelLabel2LeftTop Width�HeightCaptionfThis following SQL is used to generate a result set to test INSERT, UPDATE, DELETE operations against.  TLabelLabel3LeftTopWidthVHeightCaptionDThe query below is normally something like "SELECT * from TableName"  TMemomemSQLExecResultSQLLeftTop0Width	Height� 
ScrollBars
ssVerticalTabOrder    	TTabSheettsTestResultsCaptionTest SQL
ImageIndex TDBGridgrdResultSetLeft Top WidthHeight� AlignalClient
DataSourcedsResultSetTabOrder TitleFont.CharsetDEFAULT_CHARSETTitleFont.ColorclWindowTextTitleFont.Height�TitleFont.NameMS Sans SerifTitleFont.Style   TPanelpnlResultSetLeft Top� WidthHeight)AlignalBottom
BevelOuterbvNoneTabOrder TLabel	lblSaveAsLeftTopWidth(HeightCaptionSave As  TButtonpbSaveResultSetLeftXTopWidthaHeightCaptionSave &Results AsTabOrderOnClickpbSaveResultSetClick  TEdit	edtSaveAsLeft8Top
WidthHeightReadOnly	TabOrder OnChangeedtSaveAsChange    	TTabSheettsResultInformationCaptionResult Information
ImageIndex TLabellblTablePathLeftTopMWidth8HeightCaptionResult table  TLabellblResultTypeLeftTopWidth5HeightCaptionResult type  TLabellblErrorCodeLeftTop,Width1HeightCaption
Error code  TLabellblErrorStringLeft� Top,Width2HeightCaptionError string  TSpeedButtonbtnBroseLeft`TopHWidthHeightCaption...OnClickbtnBroseClick  TEditedtTablePathLeftPTopIWidthHeightTabOrder  TButtonbtnConfigureFilterResultLeftTophWidth� HeightCaptionConfigure FilterTabOrderOnClickbtnConfigureFilterResultClick  	TComboBoxedtRResultTypeLeftPTopWidth� HeightStylecsDropDownList
ItemHeightTabOrder Items.StringsDatasetException: Error CodeException: String   TEditedtRErrorCodeLeftPTop(Width9HeightTabOrder  TEditedtRErrorStringLeft� Top(Width� HeightTabOrder  TButtonpbExtractResultLeft�TopFWidthiHeightHintNExtracts the existing archive for the result table to the specified directory.Caption&Extract to diskTabOrderOnClickpbExtractResultClick    TPanel	pnlBottomLeft Top� Width#Height)AlignalBottomTabOrder TLabellblRecCountLeft� TopWidth:HeightCaptionlblRecCount  TButtonbtnSaveLeftTopWidthKHeightCaption&SaveDefault	TabOrder OnClickbtnSaveClick  TButton	btnCancelLeftXTopWidthKHeightCancel	CaptionCancelModalResultTabOrder  TButtonbtnTestTheTestLeft�TopWidthKHeightCaption&TestTabOrderOnClickbtnTestTheTestClick  TProgressBarbarProgressLeft� TopWidthHeightMin MaxdTabOrderVisible   TOpenDialog	dlgBrowseFilterFlashFiler Tables|*.ff2OptionsofPathMustExistofFileMustExistofEnableSizing LeftLTop�   TDataSourcedsResultSetLeftlTop�   TSaveDialogdlgSave
DefaultExtff2Filter FlashFiler 2 table (*.ff2)|*.ff2OptionsofOverwritePromptofHideReadOnlyofPathMustExistofEnableSizing TitleSave Result SetLeft(Top�    