USE ToolsStore
GO

--1--
INSERT INTO dbo.MT_LOAD_RULE_SPEC (LoadRuleId, Data, MimeType, FileName, Size, PathToFile, IsActive, DateLoad)
     VALUES(1, 
	        0xEFBBBF3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D227574662D38223F3E0D0A3C78733A736368656D6120617474726962757465466F726D44656661756C743D22756E7175616C69666965642220656C656D656E74466F726D44656661756C743D227175616C69666965642220786D6C6E733A78733D22687474703A2F2F7777772E77332E6F72672F323030312F584D4C536368656D61223E0D0A20203C78733A656C656D656E74206E616D653D227061636B6574223E0D0A202020203C78733A636F6D706C6578547970653E0D0A2020202020203C78733A73657175656E63653E0D0A20202020202020203C78733A656C656D656E74206E616D653D22686472223E0D0A202020202020202020203C78733A636F6D706C6578547970653E0D0A2020202020202020202020203C78733A73657175656E63653E0D0A20202020202020202020202020203C78733A656C656D656E74206E616D653D22747970652220747970653D2278733A737472696E6722202F3E0D0A20202020202020202020202020203C78733A656C656D656E74206E616D653D2276657273696F6E2220747970653D2278733A646563696D616C22202F3E0D0A20202020202020202020202020203C78733A656C656D656E74206E616D653D22646174652220747970653D2278733A737472696E6722202F3E0D0A2020202020202020202020203C2F78733A73657175656E63653E0D0A202020202020202020203C2F78733A636F6D706C6578547970653E0D0A20202020202020203C2F78733A656C656D656E743E0D0A20202020202020203C78733A656C656D656E74206D61784F63637572733D22756E626F756E64656422206E616D653D22726563223E0D0A202020202020202020203C78733A636F6D706C6578547970653E0D0A2020202020202020202020203C78733A73657175656E63653E0D0A20202020202020202020202020203C78733A656C656D656E74206E616D653D22436F6465223E0D0A202020202020202020202020202020203C78733A73696D706C65547970653E0D0A2020202020202020202020202020202020203C78733A7265737472696374696F6E20626173653D2278733A737472696E67223E0D0A20202020202020202020202020202020202020203C78733A6D61784C656E6774682076616C75653D22313030222F3E0D0A2020202020202020202020202020202020203C2F78733A7265737472696374696F6E3E0D0A202020202020202020202020202020203C2F78733A73696D706C65547970653E0D0A20202020202020202020202020203C2F78733A656C656D656E743E20202020202020202020202020200D0A20202020202020202020202020203C78733A656C656D656E74206E616D653D224E616D65223E0D0A202020202020202020202020202020203C78733A73696D706C65547970653E0D0A2020202020202020202020202020202020203C78733A7265737472696374696F6E20626173653D2278733A737472696E67223E0D0A20202020202020202020202020202020202020203C78733A6D61784C656E6774682076616C75653D22323530222F3E0D0A2020202020202020202020202020202020203C2F78733A7265737472696374696F6E3E0D0A202020202020202020202020202020203C2F78733A73696D706C65547970653E0D0A20202020202020202020202020203C2F78733A656C656D656E743E20202020202020202020202020202020200D0A20202020202020202020202020203C78733A656C656D656E74206E616D653D224F72642220747970653D2278733A696E7422202F3E0D0A2020202020202020202020203C2F78733A73657175656E63653E0D0A202020202020202020203C2F78733A636F6D706C6578547970653E0D0A20202020202020203C2F78733A656C656D656E743E0D0A2020202020203C2F78733A73657175656E63653E0D0A202020203C2F78733A636F6D706C6578547970653E0D0A20203C2F78733A656C656D656E743E0D0A3C2F78733A736368656D613E,
			'application/xml',
			'xsd.xsd',
			1500,
			'xsd',
			1,
			GETDATE())
GO

--2 err--
INSERT INTO dbo.MT_LOAD_RULE_SPEC (LoadRuleId, Data, MimeType, FileName, Size, PathToFile, IsActive, DateLoad)
     VALUES(1, 
	        0x00,
			'application/xml',
			'xsd.xsd',
			1500,
			'xsd',
			1,
			GETDATE())
GO

--3 err--
INSERT INTO dbo.MT_LOAD_RULE_SPEC (LoadRuleId, Data, MimeType, FileName, Size, PathToFile, IsActive, DateLoad)
     VALUES(1, 
	        null,
			'application/xml',
			'xsd.xsd',
			1500,
			'xsd',
			1,
			GETDATE())
GO

--4 err--
INSERT INTO dbo.MT_LOAD_RULE_SPEC (LoadRuleId, Data, MimeType, FileName, Size, PathToFile, IsActive, DateLoad)
     VALUES(1, 
	        0xEFBBBF3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D227574662D38223F3E0D0A3C78733A736368656D6120617474726962757465466F726D44656661756C743D22756E7175616C69666965642220656C656D656E74466F726D44656661756C743D227175616C69666965642220786D6C6E733A78733D22687474703A2F2F7777772E77332E6F72672F323030312F584D4C536368656D61223E0D0A20203C78733A656C656D656E74206E616D653D227061636B6574223E0D0A202020203C78733A636F6D706C6578547970653E0D0A2020202020203C78733A73657175656E63653E0D0A20202020202020203C78733A656C656D656E74206E616D653D22686472223E0D0A202020202020202020203C78733A636F6D706C6578547970653E0D0A2020202020202020202020203C78733A73657175656E63653E0D0A20202020202020202020202020203C78733A656C656D656E74206E616D653D22747970652220747970653D2278733A737472696E6722202F3E0D0A20202020202020202020202020203C78733A656C656D656E74206E616D653D2276657273696F6E2220747970653D2278733A646563696D616C22202F3E0D0A20202020202020202020202020203C78733A656C656D656E74206E616D653D22646174652220747970653D2278733A737472696E6722202F3E0D0A2020202020202020202020203C2F78733A73657175656E63653E0D0A202020202020202020203C2F78733A636F6D706C6578547970653E0D0A20202020202020203C2F78733A656C656D656E743E0D0A20202020202020203C78733A656C656D656E74206D61784F63637572733D22756E626F756E64656422206E616D653D22726563223E0D0A202020202020202020203C78733A636F6D706C6578547970653E0D0A2020202020202020202020203C78733A73657175656E63653E0D0A20202020202020202020202020203C78733A656C656D656E74206E616D653D22436F6465223E0D0A202020202020202020202020202020203C78733A73696D706C65547970653E0D0A2020202020202020202020202020202020203C78733A7265737472696374696F6E20626173653D2278733A737472696E67223E0D0A20202020202020202020202020202020202020203C78733A6D61784C656E6774682076616C75653D22313030222F3E0D0A2020202020202020202020202020202020203C2F78733A7265737472696374696F6E3E0D0A202020202020202020202020202020203C2F78733A73696D706C65547970653E0D0A20202020202020202020202020203C2F78733A656C656D656E743E20202020202020202020202020200D0A20202020202020202020202020203C78733A656C656D656E74206E616D653D224E616D65223E0D0A202020202020202020202020202020203C78733A73696D706C65547970653E0D0A2020202020202020202020202020202020203C78733A7265737472696374696F6E20626173653D2278733A737472696E67223E0D0A20202020202020202020202020202020202020203C78733A6D61784C656E6774682076616C75653D22323530222F3E0D0A2020202020202020202020202020202020203C2F78733A7265737472696374696F6E3E0D0A202020202020202020202020202020203C2F78733A73696D706C65547970653E0D0A20202020202020202020202020203C2F78733A656C656D656E743E20202020202020202020202020202020200D0A20202020202020202020202020203C78733A656C656D656E74206E616D653D224F72642220747970653D2278733A696E7422202F3E0D0A2020202020202020202020203C2F78733A73657175656E63653E0D0A202020202020202020203C2F78733A636F6D706C6578547970653E0D0A20202020202020203C2F78733A656C656D656E743E0D0A2020202020203C2F78733A73657175656E63653E0D0A202020203C2F78733A636F6D706C6578547970653E0D0A20203C2F78733A656C656D656E743E0D0A3C2F78733A736368656D613E,
			'application/xml',
			'    ',
			1500,
			'xsd',
			1,
			GETDATE())
GO

--5 err--
INSERT INTO dbo.MT_LOAD_RULE_SPEC (LoadRuleId, Data, MimeType, FileName, Size, PathToFile, IsActive, DateLoad)
     VALUES(1, 
	        0xEFBBBF3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D227574662D38223F3E0D0A3C78733A736368656D6120617474726962757465466F726D44656661756C743D22756E7175616C69666965642220656C656D656E74466F726D44656661756C743D227175616C69666965642220786D6C6E733A78733D22687474703A2F2F7777772E77332E6F72672F323030312F584D4C536368656D61223E0D0A20203C78733A656C656D656E74206E616D653D227061636B6574223E0D0A202020203C78733A636F6D706C6578547970653E0D0A2020202020203C78733A73657175656E63653E0D0A20202020202020203C78733A656C656D656E74206E616D653D22686472223E0D0A202020202020202020203C78733A636F6D706C6578547970653E0D0A2020202020202020202020203C78733A73657175656E63653E0D0A20202020202020202020202020203C78733A656C656D656E74206E616D653D22747970652220747970653D2278733A737472696E6722202F3E0D0A20202020202020202020202020203C78733A656C656D656E74206E616D653D2276657273696F6E2220747970653D2278733A646563696D616C22202F3E0D0A20202020202020202020202020203C78733A656C656D656E74206E616D653D22646174652220747970653D2278733A737472696E6722202F3E0D0A2020202020202020202020203C2F78733A73657175656E63653E0D0A202020202020202020203C2F78733A636F6D706C6578547970653E0D0A20202020202020203C2F78733A656C656D656E743E0D0A20202020202020203C78733A656C656D656E74206D61784F63637572733D22756E626F756E64656422206E616D653D22726563223E0D0A202020202020202020203C78733A636F6D706C6578547970653E0D0A2020202020202020202020203C78733A73657175656E63653E0D0A20202020202020202020202020203C78733A656C656D656E74206E616D653D22436F6465223E0D0A202020202020202020202020202020203C78733A73696D706C65547970653E0D0A2020202020202020202020202020202020203C78733A7265737472696374696F6E20626173653D2278733A737472696E67223E0D0A20202020202020202020202020202020202020203C78733A6D61784C656E6774682076616C75653D22313030222F3E0D0A2020202020202020202020202020202020203C2F78733A7265737472696374696F6E3E0D0A202020202020202020202020202020203C2F78733A73696D706C65547970653E0D0A20202020202020202020202020203C2F78733A656C656D656E743E20202020202020202020202020200D0A20202020202020202020202020203C78733A656C656D656E74206E616D653D224E616D65223E0D0A202020202020202020202020202020203C78733A73696D706C65547970653E0D0A2020202020202020202020202020202020203C78733A7265737472696374696F6E20626173653D2278733A737472696E67223E0D0A20202020202020202020202020202020202020203C78733A6D61784C656E6774682076616C75653D22323530222F3E0D0A2020202020202020202020202020202020203C2F78733A7265737472696374696F6E3E0D0A202020202020202020202020202020203C2F78733A73696D706C65547970653E0D0A20202020202020202020202020203C2F78733A656C656D656E743E20202020202020202020202020202020200D0A20202020202020202020202020203C78733A656C656D656E74206E616D653D224F72642220747970653D2278733A696E7422202F3E0D0A2020202020202020202020203C2F78733A73657175656E63653E0D0A202020202020202020203C2F78733A636F6D706C6578547970653E0D0A20202020202020203C2F78733A656C656D656E743E0D0A2020202020203C2F78733A73657175656E63653E0D0A202020203C2F78733A636F6D706C6578547970653E0D0A20203C2F78733A656C656D656E743E0D0A3C2F78733A736368656D613E,
			'application/xml',
			null,
			1500,
			'xsd',
			1,
			GETDATE())
GO

--6 err--
INSERT INTO dbo.MT_LOAD_RULE_SPEC (LoadRuleId, Data, MimeType, FileName, Size, PathToFile, IsActive, DateLoad)
     VALUES(1, 
	        0x00,
			'application/xml',
			'',
			1500,
			'xsd',
			1,
			GETDATE())
GO

--7 err--
INSERT INTO dbo.MT_LOAD_RULE_SPEC (LoadRuleId, Data, MimeType, FileName, Size, PathToFile, IsActive, DateLoad)
     VALUES(1, 
	        0xEFBBBF3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D227574662D38223F3E0D0A3C78733A736368656D6120617474726962757465466F726D44656661756C743D22756E7175616C69666965642220656C656D656E74466F726D44656661756C743D227175616C69666965642220786D6C6E733A78733D22687474703A2F2F7777772E77332E6F72672F323030312F584D4C536368656D61223E0D0A20203C78733A656C656D656E74206E616D653D227061636B6574223E0D0A202020203C78733A636F6D706C6578547970653E0D0A2020202020203C78733A73657175656E63653E0D0A20202020202020203C78733A656C656D656E74206E616D653D22686472223E0D0A202020202020202020203C78733A636F6D706C6578547970653E0D0A2020202020202020202020203C78733A73657175656E63653E0D0A20202020202020202020202020203C78733A656C656D656E74206E616D653D22747970652220747970653D2278733A737472696E6722202F3E0D0A20202020202020202020202020203C78733A656C656D656E74206E616D653D2276657273696F6E2220747970653D2278733A646563696D616C22202F3E0D0A20202020202020202020202020203C78733A656C656D656E74206E616D653D22646174652220747970653D2278733A737472696E6722202F3E0D0A2020202020202020202020203C2F78733A73657175656E63653E0D0A202020202020202020203C2F78733A636F6D706C6578547970653E0D0A20202020202020203C2F78733A656C656D656E743E0D0A20202020202020203C78733A656C656D656E74206D61784F63637572733D22756E626F756E64656422206E616D653D22726563223E0D0A202020202020202020203C78733A636F6D706C6578547970653E0D0A2020202020202020202020203C78733A73657175656E63653E0D0A20202020202020202020202020203C78733A656C656D656E74206E616D653D22436F6465223E0D0A202020202020202020202020202020203C78733A73696D706C65547970653E0D0A2020202020202020202020202020202020203C78733A7265737472696374696F6E20626173653D2278733A737472696E67223E0D0A20202020202020202020202020202020202020203C78733A6D61784C656E6774682076616C75653D22313030222F3E0D0A2020202020202020202020202020202020203C2F78733A7265737472696374696F6E3E0D0A202020202020202020202020202020203C2F78733A73696D706C65547970653E0D0A20202020202020202020202020203C2F78733A656C656D656E743E20202020202020202020202020200D0A20202020202020202020202020203C78733A656C656D656E74206E616D653D224E616D65223E0D0A202020202020202020202020202020203C78733A73696D706C65547970653E0D0A2020202020202020202020202020202020203C78733A7265737472696374696F6E20626173653D2278733A737472696E67223E0D0A20202020202020202020202020202020202020203C78733A6D61784C656E6774682076616C75653D22323530222F3E0D0A2020202020202020202020202020202020203C2F78733A7265737472696374696F6E3E0D0A202020202020202020202020202020203C2F78733A73696D706C65547970653E0D0A20202020202020202020202020203C2F78733A656C656D656E743E20202020202020202020202020202020200D0A20202020202020202020202020203C78733A656C656D656E74206E616D653D224F72642220747970653D2278733A696E7422202F3E0D0A2020202020202020202020203C2F78733A73657175656E63653E0D0A202020202020202020203C2F78733A636F6D706C6578547970653E0D0A20202020202020203C2F78733A656C656D656E743E0D0A2020202020203C2F78733A73657175656E63653E0D0A202020203C2F78733A636F6D706C6578547970653E0D0A20203C2F78733A656C656D656E743E0D0A3C2F78733A736368656D613E,
			'image/jpeg',
			'xsd.xsd',
			1500,
			'xsd',
			1,
			GETDATE())
GO