�
 TFORM1 0}  TPF0TForm1Form1Left� ToplCaption)FlashFiler Example - Master/Detail TablesClientHeight+ClientWidth�Color	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style Menu	MainMenu1OldCreateOrder	PixelsPerInch`
TextHeight 	TGroupBox	GroupBox1Left Top Width�Height� AlignalClientCaption	CustomersTabOrder  TDBGridDBGrid1LeftTopWidth�Height� AlignalClient
DataSourceCustomerDataTabOrder TitleFont.CharsetDEFAULT_CHARSETTitleFont.ColorclWindowTextTitleFont.Height�TitleFont.NameMS Sans SerifTitleFont.Style    	TGroupBox	GroupBox2Left Top� Width�HeightxAlignalBottomCaptionOrdersTabOrder TDBGridDBGrid4LeftTopWidth� HeightgAlignalLeft
DataSource
OrdersDataTabOrder TitleFont.CharsetDEFAULT_CHARSETTitleFont.ColorclWindowTextTitleFont.Height�TitleFont.NameMS Sans SerifTitleFont.Style ColumnsExpanded	FieldNameOrderIDVisible	 Expanded	FieldNameDateVisible	 Expanded	FieldName
CustomerIDVisible	    TDBGridDBGrid3Left� TopWidth�HeightgAlignalRight
DataSource	LinesDataTabOrderTitleFont.CharsetDEFAULT_CHARSETTitleFont.ColorclWindowTextTitleFont.Height�TitleFont.NameMS Sans SerifTitleFont.Style ColumnsExpanded	FieldName	ProductIDVisible	 Expanded	FieldNameCountVisible	 Expanded	FieldNameDescriptionVisible	 Expanded	FieldNameTotalVisible	 Expanded	FieldNameOrderIDVisible	     TffLegacyTransportltMainEnabled	
ServerNameLocalProtocolptSingleUserLeftPTop�   TFFRemoteServerEngineffRSE	TransportltMainLeft Top�   	TffClientffClientActive	
ClientNameffClientServerEngineffRSELeft(Top(  
TffSessionffSess
ClientNameffClientSessionNameExOrdersLeft(Toph  TffTableCustomerTableDatabaseNameTutorial	FieldDefs 	IndexNameSequential Access IndexReadOnly	SessionNameExOrders	TableNameEXCustTimeout'LeftPTopH  TffTableOrdersTableDatabaseNameTutorial	FieldDefs 	IndexName
ByCustomerMasterFields
CustomerIDMasterSourceCustomerDataSessionNameExOrders	TableNameEXOrdersTimeout'LeftPToph  TffTable
LinesTableDatabaseNameTutorial	FieldDefs 	IndexNameByOrderMasterFieldsOrderIDMasterSource
OrdersDataSessionNameExOrders	TableNameEXLinesTimeout'OnCalcFieldsLinesTableCalcFieldsLeft(TopH TIntegerFieldLinesTableLineID	FieldNameLineID  TIntegerFieldLinesTableOrderID	FieldNameOrderID  TIntegerFieldLinesTableProductID	FieldName	ProductID  TIntegerFieldLinesTableCount	FieldNameCountRequired	  TStringFieldLinesTableDescription	FieldKindfkLookup	FieldNameDescriptionLookupDataSetProductTableLookupKeyFields	ProductIDLookupResultFieldDescription	KeyFields	ProductIDSizeLookup	  TCurrencyFieldLinesTableTotal	FieldKindfkCalculated	FieldNameTotal
Calculated	  TCurrencyFieldLinesTablePrice	FieldKindfkLookup	FieldNamePriceLookupDataSetProductTableLookupKeyFields	ProductIDLookupResultFieldPrice	KeyFields	ProductIDLookup	   TffTableProductTableDatabaseNameTutorial	FieldDefs IndexFieldNames	ProductIDSessionNameExOrders	TableNameEXProdsTimeout'LeftPTop(  TDataSourceCustomerDataDataSetCustomerTableLeftpTopH  TDataSource
OrdersDataDataSetOrdersTableLeftxToph  TDataSource	LinesDataDataSet
LinesTableLeftpTop(  	TMainMenu	MainMenu1Left� Top( 	TMenuItemFile1Caption&File 	TMenuItemOpen1Caption&OpenOnClick
Open1Click  	TMenuItemClose1Caption&CloseOnClickClose1Click  	TMenuItemN1Caption-  	TMenuItemExit1Caption&ExitOnClick
Exit1Click     