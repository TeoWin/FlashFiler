�
 TFRMMAIN 0�  TPF0TfrmMainfrmMainLeft� Top� BorderStylebsDialogCaptionTransport TestClientHeight�ClientWidth[Color	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style OldCreateOrderOnCreate
FormCreate	OnDestroyFormDestroyOnShowFormShowPixelsPerInch`
TextHeight 	TGroupBox	GroupBox1LeftTop WidthCHeight� CaptionClient PropertiesTabOrder  	TGroupBoxgbClientStatusLeft�TopWidth� Height� CaptionStatusTabOrder  TLabellblClientStatus1LeftTopWidthFHeightCaption# good replies:  TLabellblClientStatus2LeftTop2Width@HeightCaption# bad replies:  TLabellblClientStatus3LeftTopIWidthGHeightCaptionActive threads:  TButtonpbResetLeftTopbWidth}HeightCaptionReset Client CountsTabOrder OnClickpbResetClick   	TGroupBox
gbSendParmLeft� TopWidth� Height� CaptionOptionsColor	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style ParentColor
ParentFontTabOrder TLabel
lblThreadsLeft(TopWidth-HeightCaption	# threads  TLabellblThreadMsgLeftTop)WidthGHeightCaptionMsg per thread  TLabellblServerNameLeftTopAWidth<Height	AlignmenttaRightJustifyCaptionServer name  TLabellblMaxPauseLeftTop[WidthJHeightHint<Max # of milliseconds for each pause after sending a request	AlignmenttaRightJustifyCaptionMax pause (ms)  TEditefNumThreadsLeft`TopWidthyHeightTabOrder Text10  TEditefMsgsPerThreadLeft`Top'WidthyHeightTabOrderText100  TEditefRemoteSrvNameLeft`Top?WidthyHeightTabOrderTextFF2@192.168.9.108  TEdit
efMaxPauseLeft`TopWWidthyHeightHint<Max # of milliseconds for each pause after sending a requestTabOrderText100  	TCheckBoxcbClientLogLeft`ToppWidthqHeightCaptionEvent log enabledChecked	State	cbCheckedTabOrder  	TCheckBoxcbClientLogTypeLeft`Top� Width� HeightCaptionLog requests && repliesChecked	State	cbCheckedTabOrder   TRadioGroup
rgProtocolLeftcTopWidthMHeight� CaptionProtocol	ItemIndexItems.StringsIPX/SPXSUPTCP/IP TabOrder  TButtonpbStartClientLeftTop]WidthJHeightCaption&Start ClientTabOrderOnClickpbStartClientClick  TButtonpbStopClientLeftTop~WidthKHeightCaptionSto&p ClientTabOrderOnClickpbStopClientClick  TRadioGroup
rgTestTypeLeftTopWidthQHeightACaption	Test Type	ItemIndex Items.StringsConnectSend TabOrder  TButtonpbClientSaveLogLeft� Top� WidthKHeightCaption	&Save logTabOrderOnClickpbClientSaveLogClick  TButtonpbClientClearLefthTop� WidthKHeightCaption
&Clear logTabOrderOnClickpbClientClearClick   	TGroupBox	GroupBox2LeftTop� WidthRHeight� CaptionServer PropertiesTabOrder 	TGroupBoxgbServerParamLeftbTopWidth� HeightqCaptionOptionsTabOrder  TLabel
lblSrvNameLeftTopWidth<Height	AlignmenttaRightJustifyCaptionServer name  TLabellblSrvDelayLeftTop,Width9Height	AlignmenttaRightJustifyCaptionDelay range  TEdit	efSrvNameLeftXTopWidth� HeightTabOrder TextFF2  TEdit
efSrvDelayLeftXTop(Width� HeightTabOrderText10  	TCheckBoxcbServerLogLeftXTopAWidthqHeightCaptionEvent log enabledChecked	State	cbCheckedTabOrder  	TCheckBoxcbServerLogTypeLeftXTopPWidth� HeightCaptionLog requests && repliesChecked	State	cbCheckedTabOrder   	TGroupBoxgbServerStatusLeft_TopWidth� Height� CaptionStatusTabOrder TLabellblServerStatus1LeftTopWidthFHeightCaption# good replies:  TLabellblServerStatus2LeftTop+Width@HeightCaption# bad replies:  TLabellblProtocolsLeft
TopFWidth6HeightCaption	ProtocolsFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFont  TLabellblTCPLeftTopUWidthHeightCaptionTCP:  TLabellblIPXLeftTopfWidthHeightCaptionIPX:  TLabellblSUPLeftTopvWidthHeightCaptionSUP:  TLabellblConnsLeft� TopFWidthGHeightCaptionConnectionsFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFont  TLabel
lblTCPconnLeft� TopUWidth6Height	AlignmenttaRightJustifyCaption
<tcp conn>  TLabel
lblIPXconnLeft� TopfWidth4Height	AlignmenttaRightJustifyCaption
<ipx conn>  TLabel
lblSUPconnLeft� TopvWidth8Height	AlignmenttaRightJustifyCaption
<sup conn>   TButtonpbStartServerLeftTopjWidthJHeightCaption&Start ServerTabOrderOnClickpbStartServerClick  TButtonpbStopServerLeftTop� WidthKHeightCaptionSto&p ServerTabOrderOnClickpbStopServerClick  	TGroupBoxgbProtocolsLeftbTop� Width� Height;Caption	ProtocolsTabOrder 	TCheckBoxchkServerSUPLeftTopWidthOHeightCaptionSingle UserTabOrder   	TCheckBoxchkServerTCPIPLeftTop'WidthOHeightCaptionTCP/IPChecked	State	cbCheckedTabOrder  	TCheckBoxchkServerIPXSPXLeft|TopWidthNHeightCaptionIPX/SPXEnabledTabOrder   TButtonpbFlushLeftTopHWidthKHeightCaption&Flush threadsTabOrderOnClickpbFlushClick  TButtonpbServerSaveLogLeft� Top� WidthKHeightCaption	&Save logTabOrderOnClickpbServerSaveLogClick  TButtonpbServerClearLefthTop� WidthKHeightCaption
&Clear logTabOrderOnClickpbServerClearClick   TTimer	timServerEnabledOnTimertimServerTimerLeft�Top  TTimer	timClientEnabledOnTimertimClientTimerLeft Top8   