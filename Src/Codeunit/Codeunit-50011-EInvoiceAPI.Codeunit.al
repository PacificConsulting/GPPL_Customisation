
// codeunit 50011 "E-Invoice API"
// {
//     // NAME          DATE      WORK
//     // //AR05NOV20   05NOV20   In SellerDtls, comp name is addded.

//     Permissions = TableData 32 = rimd,
//                   TableData 111 = rimd;

//     trigger OnRun()
//     var
//         ClientId: Text;
//         AuthToken: Text;
//         Sek: Text;
//         TokenExpiry: Text;
//         CancelDate: Text;
//         //ConvertCode: DotNet Convert;
//         //byteAppKey: DotNet Byte;
//         text1: Label 'enUQmNky3xZzfNs2cr51WwtdeY/b3B/zEy//ZQMZtbeLOx/O6QeAkVxOC2M6v9YXAfCHKHlO76GPNrfiGs0a0CFA99UO0uXYQsljMWH2U5cudVNqeKHK5Prz/lHBvmlOm1lh4dSMioWrVOXM7kH6TyTy830BrJvVQNc+6Lswi6RMsrtenfJdfCSmSWePiGKdEgcqEs6SGAQpwa+WPIJnU0FLK1kuoykkxKWoLv7GpvxhY0m6e3qCfVQKhptACrsy3qWdEF45oOP9JQdKXX/CjyAdDSzkCc7EzB02C38s2cbtWFYSwftVB654FaQ1sCZa6sG8svxYmeAy+sdAbxMz5lpX0zAfdtbFn8c3G1+ySOcnM+nkZC0GKVJl8C7ByG4Tu8cQqPbyxQgsF+dYvtGvxqmO6/Ef6LuwRG8RELbvGD1vnMDZ320TgU64SC6IslXGS419SO3BoT9YPLlEdPvIxM4cYH9BcuR1wDXWx/shN5+Yz2V96p7l6QS+6+d46seTNjoTA6i7oMKcru8Z7gucnwJchY7x6tUQBWei4XCsgEW0sD9g6Ucb9/D0AJ3KwpwKp3yYPAiac6IP0ulk/UB4bfJAsM1Y7PguAsXxT/xMvWK3Eo/wTe3VW3gyxM5s623';
//         text2: Label 'W19rTH4i7UhDeV21ks7L1h7Jwm8Nbr0XGTsJ7E8xT9zQPZrV26jKv2U6VEoaSt1ZHjFO5P9uG78mXPx5HySGgOMChuRoQr+wwipQ3wLLWdD8ymi2gEIxwr/C4jvK4z+b0Lvy+2G6AdXwcAGBAEXRh3VsX7sGVJ9633E8CIkh3p6Lqoep2rrHyy0dOapKzn8E8alac5PCcYy/2CudSNclCa1e3JSPj14IrDEkj3lIwnTdXwovEsFuLR38kXYthk8vrvWky4gO1Wfr2xUrKRoi3Lyz+RhSzPFDQe+AESTg3NNG46vq1HcegH4PgVko/eAdK7fdrqFqH5jUCNV7ptLrT4CX0DH+nJ8IE+66r1lbVAQiaeTRqX+XcA4dzF7fpNq5egjzva1yU4Rj5hvPo9NOIAPutLCXraHg2KrU/NG5PRjHjavr/53hIfbNsoxg86ZG4QSfYYURn6hfPddtTA+/syMpSzW5/HFihBXvN1HPktCaelqWVXGtlUyjVb8xoav2GbyntgDfVYHdGbAa88CmgFa6pCpbnxmfk7HBBB6EkhGwhq4kdmZwHtPIYxiJzL+T/nQnua2GwE1tkTU42dalfcsio3avAGT1xMPsmyUCcuryof8+KmES7ZoqRvNSsjOagDr2isBoCFTgix6d';
//         text3: Label 'WJw5ubEmJWJyKQGCdM+Fq+egcOU31jV3maZ9/FDi9kXRxlTN6QWrcvz7ySodQrLOVGGe3LmNvuKMOVMUzlun3AL1fiNHSXXx94KzL1Uah8oTf+GanMBg3D4XCxpcRorL98ziwniqh235ZrEqDgZOhWap+7rqivJEVSNYCR2ae9evQpR0Cgx4aklwvBgCxcmtNxjuI0KamsbTmSFlirM/Zimr27Z1ifLl0YqNvF9p3FQ4vdmfvQzqf5UaIQKZGDka/EHM/VNPO4rG/FT1KDNcFJZmOht6Ld8p4+J3DKwG2FE69emXFi66c5LSvbTsQ9zn+j2El2gCmiVivv58Vb8EGp4F6X6zKsD0/lzQY3/+gRcRZLZK0NKaHYefET0eay9c4sLKOptWnbTDL/Cf6RzuLJq/jd1djgYHnSriNemfXecLlFVMWYJ/JQzdi7A3ThtPMjUXqBFISgUw5xQzXWm3ziTz6VAC8p/cPcaGcWIjybf7E9BPcv+oPLu+maAww3Rmq+WkNIApfGw0CTG1LAK5Gup5ymWNdUn7ZyO3wB00By3Psoi9apezGOCnj0YUCCY2UeOSTw7S8rTVWan5c1Cgs9VlhBm2p2/JXBEqvU2gXolSS/038Bw5EfAZ/v3CCWj4GO2AdErEtF6xw595cIttceBBUxbH+qxZ2mpLNMUhq+7nmMW4XTEizc9tp9eDB5RrxZvb5OUVGJovdLdD1gO+rP3Vdnrghy2vntKT06EuwpuyPyGuZxi9jRJdvn2LAx7nWqlD+lEyqXi3DiEwYYIIDdwBGlEZH6Q3/ZrtagNIU';
//         text4: Label 'UNVDspungim1dBrSggncct05Wfhn8Jn4wzmhittDk0p45464g93W2YxOaAYUUnbDcXt95BVZ8fx82C/kE9KHJlDlMaj99rkb2T80rA+qhnZ4XIXO1BYOJMCQ6BvTIYcnv09hApT2lEHInSIKJ3o2qo7dbEocBHINgymjQ4cdOKHuszt4SVNrNOUs3qFLaEcadkvdNd6aue9TKT38efeSL4nXHeBviZqnzYmjNFoIbsK74trjNi1aJt+tO1kKaRZBOa41ns+pOA4+35TXQYH4RTM/H0Ebw7ntXESf6O89+qFZPKwUua+ifltu7UM/iah8sgTWaFjCX0VIQ3+LdtO5/oslV9rBUsxY4or2P5pPFXKygxGfObupt/l9W/aOTe6/nO+4Xs/wLnNimCWzK+Op7KOXKQYlZfxx1hjLri701ncZihqTejcRLcbjJD+Do/WbaYE4qFFo2UcnCaSpDx00N8UoHKIhg/crQyuqp8j92mwuz1K8I8XWFzNC6ONq4WuNUa4HKOkfEi/GXXUz0ISa94BtqileocRKFoBdMl4DegGqZp7v5O7uelBmguQT5e0DOZ1CM3fZ+BaWz+qqJowKEjGZo11VarGsH2PfZoeYIO5OEgyU6Y/J+UTklYPNE06bb48BkQdZ8utfHNJBUrhfwWdn/IpdUYY+VvjJvxtWqfDvn6JD8Nt6lzYYSeyPfrsBHDNEYpNCo/haLYNapl4xFnNe8FG7powm/hJ52564ncISuxGq4ssUMPqBDKKyFZB44zyh0IKAcnqxnd2hDsc2iiC+GtNzBMnEoRH4swNRjkYdCWcWhXgXqlkIqGuTsV9sFY06YWjfE2gdXl4zKNtnkqNSjs2M72SDEWFg6+cCB3IZ8FdqmXfXJh0PFLWT5Ue5hmRXMM8GUouasUjIAe5LByEZxeSmq9zV+Yf5FZl26s2EEdPqh3jRjVR1f4PYPmAGuknzU17GSqC9sMcN';
//         text5: Label '5By1SxFQgB5iVEuKEctzxTcTqcAB3g3VzG/4H3C9lwW1Mw42KwLNG64dpQ2gXWlvOeDyMlM8FEqwHdNdhaVNO1PtPTyRD1OtqcLo4TTBd9UzYuMxEpr52AGM9i0qMNTRxz5ZcdGn/Zk2RPvwM5DG7LYOe2sP7/FA31dNUzjKARUrR7xxNbgXRnONOorjHygqEN2G9FZ+/a8rptZQKsjL5WL+xZnAgAajgoE9y1qtB06K5szu1iqa5NlfgGJiVsGz6gaLYjQ70l8U0OaAofktpEZTlXfrIBmA8gvaZAN6eYuKZqZyhVmW5plsszmZlYWgOSk0ajVrOz6vpHlWcL2iQ2fsJCLcZ+QSPcqpZcDOqY41t60zDNMswnfYEbiVG8QEo1ZQgqLxGAkmJLvTfoPYv7kddrn68XlSGgyNoe4mLTVABCNr/9tTkYTPDytX29gOiYps+27CQrF4i5ksw4DfUqkjLvkLzC3oe6x6JpglY9KnpIJDl5fkPPErcuwB5uzy73zuvYbnfuCg6A4WbfihhbfEIR1Tv/BBzCGGp5jbEqrgxPhuvPWcTne2Z3g9YYmG8eliioflqZ6iZDvlJeOliX3eZohbFBqEAWxyh8Fm1MrEpkTxwd6P5vApflm99/CUANWtORGlame7deCtQOSsfh0ZUz+DsULTSwHBCma3s60k7EbUkXlmVDrUbxvV90Vz9HjlCBp+Q+DrSKzNEo46gIKfaaUSyPQg7/e4qqrYnSemORpn937a8eGupyr6+4sckQep4iGbNFrAeprSqb9VugqV6CrPrQwAUs1TKms/DfwMYr5z5w0eg4VS/eK1rRyb0PUoKab+Ry58JbJzZy2yM58eg40YeEiNKLeyGinW0l14GxSP7rfQV+fgW5DPAuC';
//         text6: Label 'uMsk/L3SPw+iq2j/iJwsIRZILVySz2GHlt+kerZt3oOKuwUd58vM6hrKWPXw0A2HACilmaNTjjhBayAwQftQcvSMTflPiinwqur5bjU+TD1zGXFF6uf+26BInvRQJa8ZirD2ezVpTlQ7JoblicOPliOngqKH3hGBqyL/e504T 0zQxQ76tw8G2qBNWSEBsqAI3QZ4IGkYwOxD7SUEa5ECo2GgnQkTvM92aERGpioddD+egPXMsxbERKWwBlBLxySXfo6lHFlbdpVs2JNXTaz5PJ/pzNRKb0CWwEIkuTY9mgmVs0j8b/LkjBzGX4Wh/mQIcNrZOkYevElLdCYUN5hg0rEhWjJKorVpGIfwKY7GwbZcCquP0BY70sLDgcM0Lkf62v0ZdZdsheUpqCmR086SRjhVpzM8dWe/9E5f2zy+362SAfmnu1XthuaMkJu8CDmAKpwJ9o2Hmh9W5fk62MxxjvHbDSGaD/XFX3It+yTtYYgQVJSPUUYikJ2Nt5NGAcHYnQs0KdifN84FEfMx4myV469HNgsGy7WSS9R7DYB0A8hrmBoFXKwEo5x5nDxTaNjyR+eY3Gloa7/wPGwjrfG0ZcUSvZIotSsZtC3pM2HjEtOXM7C7J0XAmVZe7escoVjre4sn0LYJvh+/eO0Rc8y9EO15xZrqiiYjY/yJD9VlZ1bYZGbMGunsKb81rzjzHy4vDkyL+l7QrQEILDBR2NzdUPaAlzhBSWqUfxjs=';
//         decryptedSek: Text;
//         AckNo: Text;
//         AckDt: Text;
//         Irn: Text;
//         SignedInvoice: Text;
//         SignedQRCode: Text;
//         Client_ID: Text;
//         Client_Secret: Text;
//     //TempBlob2: Record 99008535;
//     begin
//     end;

//     var
//         //[RunOnClient]
//         GetAppkey: DotNet eInv;
//         SalesInvoiceHeader: Record 112;
//         SalesCrMemoHeader: Record 114;
//         PurchaseCrMemoHeader1: Record 124;
//         StringBuilder: DotNet StringBuilder;
//         StringWriter: DotNet StringWriter;
//         JsonTextWriter: DotNet JsonTextWriter;
//         JsonFormatting: DotNet Formatting;
//         GlobalNULL: Variant;
//         IsInvoice: Boolean;
//         DocumentNo: Text[20];
//         AssGloVal: Text;
//         CgstGloVal: Text;
//         SgstGloVal: Text;
//         IgstGloVal: Text;
//         CesGloVal: Text;
//         StCesGloVal: Text;
//         CesNonAdGloval: Text;
//         DiscGlo: Text;
//         OthChrgGlo: Text;
//         PayInstr: Text;
//         CrTrn: Text;
//         DirDr: Text;
//         CrDay: Text;
//         PaidAmt: Text;
//         PaymtDue: Text;
//         InvRm: Text;
//         InvStDt: Text;
//         InvEndDt: Text;
//         InvNo: Text;
//         InvDt: Text;
//         OthRefNo: Text;
//         RecAdvRefr: Text;
//         RecAdvDt: Text;
//         TendRefr: Text;
//         ContrRefr: Text;
//         ExtRefr: Text;
//         ProjRefr: Text;
//         PORefr: Text;
//         PORefDt: Text;
//         Url: Text;
//         Docs: Text;
//         Info: Text;
//         AccDet: Text;
//         FinInsbr: Text;
//         LocVar: Code[20];
//         GetTokenURL1: Label 'https://api.einvoice1.gst.gov.in/eivital/v1.03/auth';
//         GenIRNURL1: Label 'https://api.einvoice1.gst.gov.in/eicore/v1.03/Invoice';
//         CancelIRNURL1: Label 'https://api.einvoice1.gst.gov.in/eicore/v1.03/Invoice/Cancel';
//         GetIrnDetailsText1: Label 'https://api.einvoice1.gst.gov.in/eicore/v1.03/Invoice/irn/';
//         GetGSTINDetailsText1: Label 'https://api.einvoice1.gst.gov.in/eivital/v1.03/Master/gstin/';
//         GetTokenURL: Label 'https://gsp.adaequare.com/gsp/authenticate?grant_type=token';
//         GenIRNURL: Label 'https://gsp.adaequare.com/enriched/ei/api/invoice';
//         CancelIRNURL: Label 'https://gsp.adaequare.com/enriched/ei/api/invoice/cancel';
//         GetIrnDetailsText: Label 'https://gsp.adaequare.com/enriched/ei/api/invoice/irn?irn=';
//         GetGSTINDetailsText: Label 'https://gsp.adaequare.com/enriched/ei/api/master/gstin?gstin=';
//         GenEwayBillURL: Label 'https://api.einvoice1.gst.gov.in/eiewb/v1.03/ewaybill';
//         CancelEwayBillURL: Label 'https://api.ewaybillgst.gov.in/v1.03/ewayapi';
//         PublicKey: Label 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAjo1FvyiKcQ9hDR2+vH0+O2XazuLbo2bPfRiiUnpaPhE3ly+Pwh05gvEuzo2UhUIDg98cX4E0vbfWOF1po2wWTBxb8jMY1nAJ8fz1xyHc1Wa7KZ0CeTvAGeifkMux7c22pMu6pBGJN8f3q7MnIW/uSJloJF6+x4DZcgvnDUlgZD3Pcoi3GJF1THbWQi5pDQ8U9hZsSJfpsuGKnz41QRsKs7Dz7qmcKT2WwN3ULWikgCzywfuuREWb4TVE2p3e9WuoDNPUziLZFeUfMP0NqYsiGVYHs1tVI25G42AwIVJoIxOWys8Zym9AMaIBV6EMVOtQUBbNIZufix/TwqTlxNPQVwIDAQAB';
//         GetTokenURL2: Label 'https://einv-apisandbox.nic.in/eivital/v1.03/auth';
//         GenIRNURL2: Label 'https://einv-apisandbox.nic.in/eicore/v1.03/Invoice';
//         CancelIRNURL2: Label 'https://einv-apisandbox.nic.in/eicore/v1.03/Invoice/Cancel';
//         GetIrnDetailsText2: Label 'https://einv-apisandbox.nic.in/eicore/v1.03/Invoice/irn/';
//         GetGSTINDetailsText2: Label 'https://einv-apisandbox.nic.in/eivital/v1.03/Master/gstin/';
//         GenEwayBillURL2: Label 'https://einv-apisandbox.nic.in/eiewb/v1.03/ewaybill';
//         CancelEwayBillURL2: Label 'https://einv-apisandbox.nic.in/ewaybillapi/v1.03/ewayapi';
//         PublicKeyOld: Label 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEArxd93uLDs8HTPqcSPpxZrf0Dc29r3iPp0a8filjAyeX4RAH6lWm9qFt26CcE8ESYtmo1sVtswvs7VH4Bjg/FDlRpd+MnAlXuxChij8/vjyAwE71ucMrmZhxM8rOSfPML8fniZ8trr3I4R2o4xWh6no/xTUtZ02/yUEXbphw3DEuefzHEQnEF+quGji9pvGnPO6Krmnri9H4WPY0ysPQQQd82bUZCk9XdhSZcW/am8wBulYokITRMVHlbRXqu1pOFmQMO5oSpyZU3pXbsx+OxIOc4EDX0WMa9aH4+snt18WAXVGwF2B4fmBk7AtmkFzrTmbpmyVqA3KO2IjzMZPw0hQIDAQAB';
//         CancelIRNData1: Label '{"Data": "';
//         GenerateIRNData1: Label '{"Data":"';
//         CancelEwbData1: Label '{"action": "CANEWB","Data":"';
//         Data2: Label '"}';
//         decry: Label 'IDPK3ENYkCLejvTAn0hweiT3GNykbitMLQwiKPWmBGHXGt+337lIxvN19/WtV/5v96oj4XjGkOvrekyZpdo+KyOpsIscG1r+hCf7nB5VWr4onEjG/H/NalAa9PhA+1xN76b18Z7Tn1eTcHIw/Gbawg==';
//         dcrtCancel: Label 'kJTDb22RoXufFryg/5lCy8oLdG2pmW4/sT9mCfyzrAILAA1XFwzgWcE/Oqkgvf5jXgYP5ohCmZpf7+spq7+pyNvYXtpfFzI1PBubqo5htOTsPbymWAoODWE+Rfz+izAGgPKNA3gVn00uq7Zpf77HGg==';
//         SignedInv: Label 'eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNyc2Etc2hhMjU2Iiwia2lkIjoiMTE1RjQ0MjY2MTdBNzkzOEJFMUJBMDZEQkVFOTFBNDI3NTg0RURBQiIsInR5cCI6IkpXVCIsIng1dCI6IkVWOUVKbUY2ZVRpLUc2QnR2dWthUW5XRTdhcyJ9.eyJkYXRhIjoie1wiQWNrTm9cIjoxNDEwMDEzNzYzMCxcIkFja0R0XCI6XCIyMDIwLTAyLTEwIDE1OjE2OjAwXCIsXCJWZXJzaW9uXCI6XCIxLjBcIixcIklyblwiOlwiOGYzNzkzYThjODZkMzhjMDdmMTI5OGJhNjE3NDg3ZTM5ZTkwMjE1NjYxMjMyMzUyZTA1M2QwZDZiZWVmNWFhN1wiLFwiVHJhbkR0bHNcIjp7XCJDYXRnXCI6XCJCMkJcIixcIlJlZ1JldlwiOlwiUkdcIixcIlR5cFwiOlwiUkVHXCIsXCJFY21Ucm5cIjpcIk5cIixcIkVjbUdzdGluXCI6XCJcIn0sXCJEb2NEdGxzXCI6e1wiVHlwXCI6XCJJTlZcIixcIk5vXCI6XCJZMDEwODAwMDVZNVwiLFwiRHRcIjpcIjIwMTktMTEtMjhcIixcIk9yZ0ludk5vXCI6XCJBTklMMjAyMDAxMDgwMDAxXCJ9LFwiU2VsbGVyRHRsc1wiOntcIkdzdGluXCI6XCIzNkFNQlBHNzc3M00wMDJcIixcIlRyZE5tXCI6XCJUcmFkZSBOYW1lMVwiLFwiQm5vXCI6XCIxXCIsXCJCbm1cIjpcIlwiLFwiRmxub1wiOlwiXCIsXCJMb2NcIjpcIkxvY2F0aW9uXCIsXCJEc3RcIjpcIlwiLFwiUGluXCI6NTYwMDQzLFwiU3RjZFwiOjI5LFwiRW1cIjpcImFiY0B4eXouY29tXCJ9LFwiQnV5ZXJEdGxzXCI6e1wiR3N0aW5cIjpcIjI5QUFHUEI4Njc4TDF';
//         SignedInv1: Label 'aMVwiLFwiVHJkTm1cIjpcIlRyYWRlIE5hbWUxXCIsXCJCbm9cIjpcIjFcIixcIkJubVwiOlwiXCIsXCJGbG5vXCI6XCJcIixcIkxvY1wiOlwiTG9jYXRpb25cIixcIkRzdFwiOlwiXCIsXCJQaW5cIjo1NjAwNDMsXCJTdGNkXCI6MjksXCJFbVwiOlwiYWJjQHh5ei5jb21cIn0sXCJEaXNwRHRsc1wiOntcIkdzdGluXCI6XCIyOUFBR1BCODY3OEwxWjFcIixcIlRyZE5tXCI6XCJuYW1lIFwiLFwiQm5vXCI6XCIxMjNcIixcIkJubVwiOlwiXCIsXCJGbG5vXCI6XCIyXCIsXCJMb2NcIjpcImxvY2F0aW9uXCIsXCJEc3RcIjpcIlwiLFwiUGluXCI6NTYwMDQzLFwiU3RjZFwiOjI5LFwiRW1cIjpcImFiQ0BYWVouQ09NXCJ9LFwiU2hpcER0bHNcIjp7XCJHc3RpblwiOlwiMjlBQUdQQjg2NzhMMVoxXCIsXCJUcmRObVwiOlwibmFtZSBcIixcIkJub1wiOlwiMTIzXCIsXCJCbm1cIjpcIlwiLFwiRmxub1wiOlwiMlwiLFwiTG9jXCI6XCJsb2NhdGlvblwiLFwiRHN0XCI6XCJcIixcIlBpblwiOjU2MDA0MyxcIlN0Y2RcIjoyOSxcIkVtXCI6XCJhYkNAWFlaLkNPTVwifSxcIkl0ZW1MaXN0XCI6W3tcIkl0ZW1Ob1wiOjEsXCJQcmRObVwiOlwiV2hlYXRcIixcIlByZERlc2NcIjpcIldoZWF0IGRlc2NcIixcIkhzbkNkXCI6XCIxMDAxXCIsXCJRdHlcIjoxLFwiRnJlZVF0eVwiOjAsXCJVbml0XCI6XCJLR1NcIixcIlVuaXRQcmljZVwiOjAsXCJUb3RBbXRcIjowLFwiRGlzY291bnRcIjowLFwiT3RoQ2hyZ1wiOjAsXCJBc3NBbXRcIjowLFwiQ2dzdFJ0XCI6MyxcIlNnc3R';
//         SignedInv2: Label 'SdFwiOjMsXCJJZ3N0UnRcIjowLFwiQ2VzUnRcIjowLFwiQ2VzTm9uQWRWYWxcIjowLFwiU3RhdGVDZXNcIjozNixcIlRvdEl0ZW1WYWxcIjoyMzQzMn1dLFwiVmFsRHRsc1wiOntcIkFzc1ZhbFwiOjEwLFwiQ2dzdFZhbFwiOjIsXCJTZ3N0VmFsXCI6MixcIklnc3RWYWxcIjowLFwiQ2VzVmFsXCI6MCxcIlN0Q2VzVmFsXCI6MCxcIkNlc05vbkFkVmFsXCI6MCxcIkRpc2NcIjowLFwiT3RoQ2hyZ1wiOjAsXCJUb3RJbnZWYWxcIjowfSxcIkV4cER0bHNcIjp7XCJFeHBDYXRcIjpcIlNFWlwiLFwiV3RoUGF5XCI6XCJOXCIsXCJTaGlwQk5vXCI6XCJcIixcIlNoaXBCRHRcIjpcIjIwMTktMTEtMjhcIixcIlBvcnRcIjpcIlwiLFwiSW52Rm9yQ3VyXCI6MjM0NDUsXCJGb3JDdXJcIjpcIkJEVFwiLFwiQ250Q29kZVwiOlwiQkRcIn0sXCJQYXlEdGxzXCI6e1wiTmFtXCI6XCJcIixcIk1vZGVcIjpcIkNBU0hcIixcIkZpbkluc0JyXCI6XCJcIixcIlBheVRlcm1cIjpcIjEwMDFcIixcIlBheUluc3RyXCI6XCJcIixcIkNyVHJuXCI6XCJcIixcIkRpckRyXCI6XCJcIixcIkNyRGF5XCI6MixcIkJhbEFtdFwiOjIsXCJQYXlEdWVEdFwiOlwiMjAxOS0xMS0yOFwiLFwiQWNjdERldFwiOlwiMTBcIn0sXCJSZWZEdGxzXCI6e1wiSW52Um1rXCI6XCIwXCIsXCJJbnZTdER0XCI6XCIyMDE5LTExLTI4XCIsXCJJbnZFbmREdFwiOlwiMjAxOS0xMS0yOFwiLFwiUHJlY0ludk5vXCI6XCJcIixcIlByZWNJbnZEdFwiOlwiMjAxOS0xMS0yOFwiLFwiSW52UmVmTm9cIjpcIjBcIix';
//         SignedInv3: Label 'cIlJlY0FkdlJlZlwiOlwiXCIsXCJUZW5kUmVmXCI6XCJcIixcIkNvbnRyUmVmXCI6XCIxMFwiLFwiRXh0UmVmXCI6XCIyXCIsXCJQcm9qUmVmXCI6XCJcIixcIlBPUmVmXCI6XCJcIn19IiwiaXNzIjoiTklDIn0.aYAuMqyb06GksBHDZuIO5N6t2VCsd-sRHbWNgIVbH-W2nRI9COEq_NMym1R4Jm1IpDyyFE9F6WDEihJGqhPvch6fawBUcPxF67osf6YFcS0K3N6MqiemvL1dSTbP0lI5ixtmu9jYctRh77bAiGcZmUfw7NNtO7cMw660_jystxwkvx8YUuAMJrAjsMriSr0CUngWXpPdAud7h-PmPwsQnpORUvGZASMYgExTqZz1Il20wN1e_dO3pJhW9vfHDigTu6yybmchrUtZdBZsVLjaBysNoGokW4OTkiJ6hdhJIxekkJytqixO71NlgoWywBzdGRSrzgdo_tMvSqPSL1wZ4w';
//         TextQrCode: Label 'eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNyc2Etc2hhMjU2Iiwia2lkIjoiMTE1RjQ0MjY2MTdBNzkzOEJFMUJBMDZEQkVFOTFBNDI3NTg0RURBQiIsInR5cCI6IkpXVCIsIng1dCI6IkVWOUVKbUY2ZVRpLUc2QnR2dWthUW5XRTdhcyJ9.eyJkYXRhIjoie1wiU2VsbGVyR3N0aW5cIjpcIjIzQUFCQ1M1Mjk1QjJaTFwiLFwiQnV5ZXJHc3RpblwiOlwiMjhBQUFDRzA1NjlQMVozXCIsXCJEb2NOb1wiOlwiWVNSMDEyM0FZU3IwMjJcIixcIkRvY1R5cFwiOlwiSU5WXCIsXCJEb2NEdFwiOlwiMjAxOS0wNS0xMlwiLFwiVG90SW52VmFsXCI6MTI0MDAsXCJJdGVtQ250XCI6MSxcIk1haW5Ic25Db2RlXCI6XCIxMDAxXCIsXCJJcm5cIjpcImY4ZTdkZjNmYjM5ZmM5ODM5OTM2Njk1ZmQ2ZDc1Nzc0NWQ1MDFkNzNlMjRhZjAzMzdlNDhhMmYwN2U4ODJlNmFcIn0iLCJpc3MiOiJOSUMifQ.Oehth9aWBx8voepuG4J95nCSBeTjzlXflWbqy8INAMjbjTL8PwvZB0ykloBdzIT79bwBHTgPx6dM2w6K1RlhH-Qm9MusmLOs-Ab6hwjZ9a42Cx1Qk-54ovcvroUs9FDF3bmZjE36QxAXC2wzbQVbCn_au9yu9KrAN4CJ2QDqCw4AtSgXa1J0QK18OoyHpnor7yUxXItK4xJLuwS6FaXlIn8Wuy8Xp5LuCBCor0vaE23sd8LGA4eNSY9pSb9o83Et1ueoC4jMz17pR-651ENGH_uEzboD141pGvCLP2SwovJD42gj3ElXILoqKeTjB7vLk16IpzPKwqY0AwbfJsf9rA';
//         UnRegCusrErr: Label 'E-Invoicing is not applicable for Unregistered Customer.';
//         RecIsEmptyErr: Label 'Record variable uninitialized.';
//         SalesLinesErr: Label 'E-Invoice allowes only 100 lines per Invoice. Curent transaction is having %1 lines.', Comment = '%1 = Sales Lines count';
//         IsPurchCrMemo: Boolean;

//     // [Scope('Internal')]
//     procedure EncryptAsymmetric(prString: Text) EncryptedString: Text
//     var
//         [RunOnClient]
//         EncryptGetToken: DotNet eInv;
//         txtEncryted: Text;
//     begin
//         EncryptGetToken := EncryptGetToken.eInv;
//         EncryptedString := EncryptGetToken.EncryptAsymmetric(prString, PublicKey);
//     end;

//     // [Scope('Internal')]
//     procedure GetToken_Govt(UserName: Text; Password: Text; ForceRefreshAccessToken: Boolean; var ClientId: Text; var AuthToken: Text; var Sek: Text; var TokenExpiry: Text; var decryptedSek: Text; Client_ID: Text; Client_Secret: Text)
//     var
//         Token: Label 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzY29wZSI6WyJnc3AiXSwiZXhwIjoxNTY2ODEzMzUwLCJhdXRob3JpdGllcyI6WyJST0xFX1NCX0VfQVBJX0dTVF9SRVRVUk5TIiwiUk9MRV9TQl9FX0FQSV9FV0IiXSwianRpIjoiYjlhNDUxZWEtNzZkOC00N2U3LTg2ZDktNzJhMTk2MjM2MmNhIiwiY2xpZW50X2lkIjoiRTRCMTcyNDMzNkE5NDI5Q0ExQjM4M0ZEODAzMjBCOEYifQ.1BGkFnecJeY0aaQveGdadj9zU5iRe4qaMJ81HKzKOh8';
//         HttpClient: DotNet HttpClient;
//         URI: DotNet Uri;
//         ReqHdr: DotNet HttpRequestHeaders;
//         HttpStringContent: DotNet StringContent;
//         txtJsonResult: Text;
//         Encoding: DotNet Encoding;
//         HttpResponseMessage: DotNet HttpResponseMessage;
//         JObject: DotNet JObject;
//         txtSuccess: Text;
//         txtJsonResponse: Text;
//         txtResult: Text;
//         txtJsonRequest: Text;
//         TextAppKey: Label 'dN+eAtmvwlz/2rsFe5dXkTps08mMko5Q3uvRsYGIPaT9/BcsfwlR8vnuz47VBRooif2Z9wnCUogApf28IRb91OMPs81U9ON7uvE9qyWFhM+8gBj6kFlwj9oBYfRAiO8Ht8YEqXFs+ZCQkFIu3PsvfKl26w1j8xj1HcaPYeVhchJtvp/zBuo8Uk9fwFDeZRjpJwgnJwLw/wx5O2sydhuUm7srI/FIWZVch2+n9TMRueK4twHm/m7xEQQl3k4kmZTguYa9FmsSRb0HDhtqQsOfz7pB7wm6oVzJR01FKn8fTx2diuZSSy6ycc5o6xM65Vj5EkeDeglAcCXTKYP5jE1b4A==';
//         byteAppKey: DotNet Byte;
//         recGeneralLedgerSetup: Record "98";
//         decMinutes: Decimal;
//         intYear: Integer;
//         intMonth: Integer;
//         intDay: Integer;
//         dtTokenExpiry: DateTime;
//         txtTime: Text;
//         tTime: Time;
//         txtYear: Text;
//         txtMonth: Text;
//         txtDay: Text;
//         AppKey: Text;
//         LocRec: Record "14";
//     begin
//         /*
//         recGeneralLedgerSetup.GET;

//         IF  FORMAT(recGeneralLedgerSetup."E-Inv Token Expiry")  <>  ''  THEN  BEGIN
//           decMinutes :=  CURRENTDATETIME - recGeneralLedgerSetup."E-Inv Token Expiry";
//           decMinutes :=  ROUND(decMinutes / 60000,  1);

//         //330 ->  Generating token only after 5.5 hours
//           IF  decMinutes < 330 THEN  BEGIN
//             AuthToken  :=  recGeneralLedgerSetup."E-Inv Token";
//             Sek  :=  recGeneralLedgerSetup."E-Inv Sek";
//             //EXIT;
//           END;
//         END;
//          */

//         IF LocRec.GET(LocVar) THEN;

//         IF FORMAT(LocRec."E-Inv Token Expiry") <> '' THEN BEGIN
//             decMinutes := CURRENTDATETIME - LocRec."E-Inv Token Expiry";
//             decMinutes := ROUND(decMinutes / 60000, 1);

//             //330 ->  Generating token only after 5.5 hours
//             IF decMinutes < 330 THEN BEGIN
//                 AuthToken := LocRec."E-Inv Token";
//                 Sek := LocRec."E-Inv Sek";
//                 //EXIT;
//             END;
//         END;

//         //CLEARALL;
//         GetAppkey := GetAppkey.eInv;

//         GetServiceProtol;
//         byteAppKey := GetAppkey.generateSecureKey();
//         AppKey := GetAppkey.Encrypt(byteAppKey, PublicKey);
//         txtJsonRequest := CreateJsonGetToken(UserName, EncryptAsymmetric(Password), AppKey, ForceRefreshAccessToken);
//         txtJsonRequest := '{"data":' + txtJsonRequest + '}';
//         IF USERID = 'GPUAE\FAHIM.AHMAD' THEN
//             MESSAGE(txtJsonRequest);

//         HttpClient := HttpClient.HttpClient;
//         URI := URI.Uri(GetTokenURL);
//         HttpClient.BaseAddress(URI);
//         HttpClient.DefaultRequestHeaders.Add('Client_ID', Client_ID);
//         HttpClient.DefaultRequestHeaders.Add('Client_Secret', Client_Secret);
//         HttpStringContent := HttpStringContent.StringContent(txtJsonRequest, Encoding.UTF8, 'application/json');
//         HttpResponseMessage := HttpClient.PostAsync(URI, HttpStringContent).Result;
//         txtJsonResponse := HttpResponseMessage.Content.ReadAsStringAsync().Result;

//         //MESSAGE(txtJsonResponse);

//         JObject := JObject.JObject;
//         JObject := JObject.Parse(txtJsonResponse);
//         JObject := JObject.GetValue('Status');
//         IF JObject.ToString = '0' THEN BEGIN
//             JObject := JObject.JObject;
//             JObject := JObject.Parse(txtJsonResponse);
//             JObject := JObject.GetValue('ErrorDetails');

//             ERROR(JObject.ToString)
//         END ELSE BEGIN
//             JObject := JObject.JObject;
//             JObject := JObject.Parse(txtJsonResponse);
//             JObject := JObject.GetValue('Data');
//             txtResult := JObject.ToString;

//             JObject := JObject.JObject;
//             JObject := JObject.Parse(txtResult);
//             JObject := JObject.GetValue('ClientId');
//             ClientId := JObject.ToString;

//             JObject := JObject.JObject;
//             JObject := JObject.Parse(txtResult);
//             JObject := JObject.GetValue('AuthToken');
//             AuthToken := JObject.ToString;

//             //recGeneralLedgerSetup."E-Inv Token" :=  AuthToken;
//             LocRec."E-Inv Token" := AuthToken;

//             JObject := JObject.JObject;
//             JObject := JObject.Parse(txtResult);
//             JObject := JObject.GetValue('Sek');
//             Sek := JObject.ToString;
//             decryptedSek := Sek;
//             Sek := GetAppkey.DecryptBySymmetricKey(Sek, byteAppKey);

//             //recGeneralLedgerSetup."E-Inv Sek" :=  Sek;
//             LocRec."E-Inv Sek" := Sek;
//             JObject := JObject.JObject;
//             JObject := JObject.Parse(txtResult);
//             JObject := JObject.GetValue('TokenExpiry');
//             TokenExpiry := JObject.ToString;


//             //Time  Begin
//             txtYear := COPYSTR(TokenExpiry, 1, 4);
//             txtMonth := COPYSTR(TokenExpiry, 6, 2);
//             txtDay := COPYSTR(TokenExpiry, 9, 2);

//             EVALUATE(intYear, txtYear);
//             EVALUATE(intMonth, txtMonth);
//             EVALUATE(intDay, txtDay);
//             txtTime := COPYSTR(TokenExpiry, 12, 16);
//             EVALUATE(tTime, txtTime);
//             dtTokenExpiry := CREATEDATETIME(DMY2DATE(intDay, intMonth, intYear), tTime);
//             //recGeneralLedgerSetup."E-Inv Token Expiry"  :=  dtTokenExpiry;
//             //recGeneralLedgerSetup.MODIFY;
//             LocRec."E-Inv Token Expiry" := dtTokenExpiry;
//             LocRec.MODIFY;
//             //Time  End
//             //MESSAGE('Token generated successfully')
//         END;

//     end;

//     local procedure CreateJsonGetToken(UserName: Text; Password: Text; AppKey: Text; ForceRefreshAccessToken: Boolean): Text
//     var
//         StringBuilder: DotNet StringBuilder;
//         StringWriter: DotNet StringWriter;
//         JSON: DotNet String;
//         JSONTextWriter: DotNet JsonTextWriter;
//         JSONTextWriter2: DotNet JsonWriter;
//     begin

//         StringBuilder := StringBuilder.StringBuilder;
//         StringWriter := StringWriter.StringWriter(StringBuilder);
//         JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);


//         JSONTextWriter.WriteStartObject;

//         CreateJsonAttributeGetToken('UserName', UserName, JSONTextWriter, FALSE);
//         CreateJsonAttributeGetToken('Password', Password, JSONTextWriter, FALSE);
//         CreateJsonAttributeGetToken('AppKey', AppKey, JSONTextWriter, FALSE);
//         CreateJsonAttributeGetToken('ForceRefreshAccessToken', ForceRefreshAccessToken, JSONTextWriter, TRUE);


//         JSONTextWriter.WriteEndObject;

//         EXIT(StringBuilder.ToString);
//     end;

//     local procedure CreateJsonAttributeGetToken(PropertyName: Text; Value: Variant; JSONTextWriter: DotNet JsonWriter; isBool: Boolean)
//     var
//         StringWriter: DotNet StringWriter;
//     begin
//         JSONTextWriter.WritePropertyName(PropertyName);
//         IF PropertyName = 'ForceRefreshAccessToken' THEN BEGIN
//             IF FORMAT(Value) = 'No' THEN
//                 JSONTextWriter.WriteValue(FALSE)
//             ELSE
//                 JSONTextWriter.WriteValue(TRUE);
//         END ELSE BEGIN
//             JSONTextWriter.WriteValue(Value);
//         END;
//     end;

//     [Scope('Internal')]
//     procedure GenerateIRN_Govt(DocumentNo: Text; AuthToken: Text; Sek: Text; var AckNo: Text; var AckDt: Text; var Irn: Text; var SignedInvoice: Text; var SignedQRCode: Text; Client_ID: Text; Client_Secret: Text; GSTIN: Text; UserName: Text)
//     var
//         Token: Label 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzY29wZSI6WyJnc3AiXSwiZXhwIjoxNTY2ODEzMzUwLCJhdXRob3JpdGllcyI6WyJST0xFX1NCX0VfQVBJX0dTVF9SRVRVUk5TIiwiUk9MRV9TQl9FX0FQSV9FV0IiXSwianRpIjoiYjlhNDUxZWEtNzZkOC00N2U3LTg2ZDktNzJhMTk2MjM2MmNhIiwiY2xpZW50X2lkIjoiRTRCMTcyNDMzNkE5NDI5Q0ExQjM4M0ZEODAzMjBCOEYifQ.1BGkFnecJeY0aaQveGdadj9zU5iRe4qaMJ81HKzKOh8';
//         HttpClient: DotNet HttpClient;
//         URI: DotNet Uri;
//         ReqHdr: DotNet HttpRequestHeaders;
//         HttpStringContent: DotNet StringContent;
//         txtJsonResult: Text;
//         HttpResponseMessage: DotNet HttpResponseMessage;
//         JObject: DotNet JObject;
//         Encoding: DotNet Encoding;
//         txtSuccess: Text;
//         txtJsonResponse: Text;
//         txtResult: Text;
//         txtJsonRequest: Text;
//         TextAppKey: Label 'dN+eAtmvwlz/2rsFe5dXkTps08mMko5Q3uvRsYGIPaT9/BcsfwlR8vnuz47VBRooif2Z9wnCUogApf28IRb91OMPs81U9ON7uvE9qyWFhM+8gBj6kFlwj9oBYfRAiO8Ht8YEqXFs+ZCQkFIu3PsvfKl26w1j8xj1HcaPYeVhchJtvp/zBuo8Uk9fwFDeZRjpJwgnJwLw/wx5O2sydhuUm7srI/FIWZVch2+n9TMRueK4twHm/m7xEQQl3k4kmZTguYa9FmsSRb0HDhtqQsOfz7pB7wm6oVzJR01FKn8fTx2diuZSSy6ycc5o6xM65Vj5EkeDeglAcCXTKYP5jE1b4A==';
//         byteAppKey: DotNet Byte;
//         ErrorDetails: Text;
//         ErrorMessage: Text;
//         ErrorDetailsPos1: Integer;
//         ErrorDetailsPos2: Integer;
//         ConvertCode: DotNet Convert;
//         RecTransferShip: Record 5744;
//         ErrorMsg: Label 'Duplicate IRN';
//         IRNQRCodeUpdation: Report 50250;
//         DupIRN: Text;
//         InfoDtls: Text;
//         Desc: Text;
//         InfoDtlsPos1: Integer;
//         InfoDtlsPos2: Integer;
//         DescPos1: Integer;
//         DescPos2: Integer;
//     begin
//         //CLEARALL;

//         GetServiceProtol;
//         GetAppkey := GetAppkey.eInv;
//         byteAppKey := GetAppkey.generateSecureKey();
//         //AppKey  :=  GetAppkey.GetAppkey.GetAppkey.EncryptBySymmetricKey(byteAppKey,PublicKey);

//         IF RecTransferShip.GET(DocumentNo) THEN
//             txtJsonRequest := DynamicJsonTransferReturn(DocumentNo)
//         ELSE
//             txtJsonRequest := DynamicJsonReturn(DocumentNo);

//         IF (USERID = 'ROBOSOFT.SUPPORT2') OR (USERID = 'ROBOSOFT.SUPPORT1') OR (USERID = 'GPUAE\FAHIM.AHMAD') THEN
//             MESSAGE(txtJsonRequest);
//         txtJsonRequest := GetAppkey.Base64Encode(txtJsonRequest);
//         //MESSAGE(txtJsonRequest);
//         txtJsonRequest := GetAppkey.EncryptBySymmetricKey(txtJsonRequest, Sek);
//         txtJsonRequest := GenerateIRNData1 + txtJsonRequest + Data2;

//         //MESSAGE(txtJsonRequest);

//         HttpClient := HttpClient.HttpClient;
//         URI := URI.Uri(GenIRNURL);
//         HttpClient.BaseAddress(URI);
//         HttpClient.DefaultRequestHeaders.Add('Client_ID', Client_ID);
//         HttpClient.DefaultRequestHeaders.Add('Client_Secret', Client_Secret);
//         HttpClient.DefaultRequestHeaders.Add('Gstin', GSTIN);
//         HttpClient.DefaultRequestHeaders.Add('user_name', UserName);
//         HttpClient.DefaultRequestHeaders.Add('AuthToken', AuthToken);

//         HttpStringContent := HttpStringContent.StringContent(txtJsonRequest, Encoding.UTF8, 'application/json');
//         HttpResponseMessage := HttpClient.PostAsync(URI, HttpStringContent).Result;
//         txtJsonResponse := HttpResponseMessage.Content.ReadAsStringAsync().Result;

//         IF (USERID = 'ROBOSOFT.SUPPORT2') OR (USERID = 'ROBOSOFT.SUPPORT1') OR (USERID = 'GPUAE\FAHIM.AHMAD') THEN
//             MESSAGE('txtJsonResponse  = ' + txtJsonResponse);

//         JObject := JObject.JObject;
//         JObject := JObject.Parse(txtJsonResponse);
//         JObject := JObject.GetValue('Status');
//         IF JObject.ToString = '0' THEN BEGIN
//             JObject := JObject.JObject;
//             JObject := JObject.Parse(txtJsonResponse);
//             JObject := JObject.GetValue('ErrorDetails');

//             ErrorDetails := JObject.ToString;
//             //  MESSAGE('ErrorDetails : ' +ErrorDetails);

//             ErrorDetailsPos1 := STRPOS(ErrorDetails, '{');
//             ErrorDetailsPos2 := STRPOS(ErrorDetails, '}');
//             ErrorDetails := COPYSTR(ErrorDetails, ErrorDetailsPos1 + 1, ErrorDetailsPos2 - 1);
//             ErrorDetailsPos2 := STRPOS(ErrorDetails, '}');
//             ErrorDetails := '{' + COPYSTR(ErrorDetails, 1, ErrorDetailsPos2 - 1) + '}';
//             //  MESSAGE('ErrorDetails123 : ' +ErrorDetails);

//             JObject := JObject.JObject;
//             JObject := JObject.Parse(ErrorDetails);
//             JObject := JObject.GetValue('ErrorMessage');
//             ErrorMessage := JObject.ToString;

//             //DJ update IRN detail if Duplicate
//             IF ErrorMessage = ErrorMsg THEN BEGIN
//                 JObject := JObject.JObject;
//                 JObject := JObject.Parse(txtJsonResponse);
//                 JObject := JObject.GetValue('InfoDtls');
//                 InfoDtls := JObject.ToString;

//                 InfoDtlsPos1 := STRPOS(InfoDtls, '{');
//                 InfoDtlsPos2 := STRPOS(InfoDtls, '}');
//                 InfoDtls := COPYSTR(InfoDtls, InfoDtlsPos1 + 1, InfoDtlsPos2 - 1);
//                 InfoDtlsPos2 := STRPOS(InfoDtls, '}');
//                 InfoDtls := COPYSTR(InfoDtls, 1, InfoDtlsPos2 - 1);

//                 DescPos1 := STRPOS(InfoDtls, '{');
//                 DescPos2 := STRLEN(InfoDtls);
//                 Desc := '{' + COPYSTR(InfoDtls, DescPos1 + 1, DescPos2) + '}';

//                 JObject := JObject.JObject;
//                 JObject := JObject.Parse(Desc);
//                 JObject := JObject.GetValue('Irn');
//                 DupIRN := JObject.ToString;

//                 IRNQRCodeUpdation.SetDocument(LocVar, DocumentNo, DupIRN);
//                 IRNQRCodeUpdation.RUN;
//             END ELSE
//                 //DJ update IRN detail if Duplicate
//                 ERROR(ErrorMessage);
//         END ELSE BEGIN
//             JObject := JObject.JObject;
//             JObject := JObject.Parse(txtJsonResponse);
//             JObject := JObject.GetValue('Data');
//             txtResult := JObject.ToString;

//             txtResult := GetAppkey.DecryptBySymmetricKey(txtResult, ConvertCode.FromBase64String(Sek));
//             txtResult := GetAppkey.Base64Decode(txtResult);


//             JObject := JObject.JObject;
//             JObject := JObject.Parse(txtResult);
//             JObject := JObject.GetValue('AckNo');
//             AckNo := JObject.ToString;

//             JObject := JObject.JObject;
//             JObject := JObject.Parse(txtResult);
//             JObject := JObject.GetValue('AckDt');
//             AckDt := JObject.ToString;

//             JObject := JObject.JObject;
//             JObject := JObject.Parse(txtResult);
//             JObject := JObject.GetValue('Irn');
//             Irn := JObject.ToString;

//             JObject := JObject.JObject;
//             JObject := JObject.Parse(txtResult);
//             JObject := JObject.GetValue('SignedInvoice');
//             SignedInvoice := JObject.ToString;

//             JObject := JObject.JObject;
//             JObject := JObject.Parse(txtResult);
//             JObject := JObject.GetValue('SignedQRCode');
//             SignedQRCode := JObject.ToString;

//             //MESSAGE(SignedQRCode);

//             MESSAGE('Irn generated successfully')
//         END;
//     end;

//     [Scope('Internal')]
//     procedure JsonReturn(): Text
//     var
//         NoSeriesMgt: Codeunit "396";
//         cdNo: Code[20];
//         cdNoSeries: Code[20];
//     begin
//         NoSeriesMgt.InitSeries('HOJVNOS', 'HOJVNOS', 0D, cdNo, cdNoSeries);

//         EXIT(
//         '{'
//          + ' "TaxSch": "GST",'
//         + '  "Version": "1.00",'
//         + '  "Irn": "",'
//         + '  "TranDtls": {'
//         + '    "Catg": "B2B",'
//         + '    "RegRev": "RG",'
//         + '    "Typ": "REG",   '
//         + '    "EcmTrn": "Y",'
//         + '    "EcmGstin": "37BZNPM9430M1KL"'
//         + ' },'
//         + '  "DocDtls": {'
//         + '    "Typ": "INV",'
//         + '    "No": "' + cdNo + '",'
//         + '    "Dt": "2019-05-12"'
//         + '  },'
//         + '  "SellerDtls": {'
//         + '    "Gstin": "23AABCS5295B2ZL",'
//         + '    "TrdNm": "AMBIKA CEMENTS",'
//         + '   "Bno": "1",'
//         + '    "Bnm": "AMBIKA CEMENTS",'
//         + '    "Flno": "2",'
//         + '    "Loc": "BENGALURU",'
//         + '    "Dst": "BANGALURU",'
//         + '    "Pin": 560090,'
//         + '    "Stcd": 29,'
//         + '    "Ph": 9898989898,'
//         + '    "Em": "abc123@gmail.com"'
//         + '  },'
//         + '  "BuyerDtls": {'
//         + '    "Gstin": "28AAACG0569P1Z3",'
//         + '    "TrdNm": "LAKSHMI ENTERPRISES",'
//         + '    "Bno": "785",'
//         + '    "Bnm": "",'
//         + '    "Flno": "",'
//         + '   "Loc": "BANGALORE",'
//         + '    "Dst": "",'
//         + '    "Pin": 560054,'
//         + '    "Stcd": 29,'
//         + '    "Ph": 9898989898,'
//         + '    "Em": "abc123@gmail.com"'
//         + '  },'
//         + '  "ValDtls": {'
//         + '    "AssVal": 10000,'
//         + '    "SgstVal": 1200,'
//         + '    "CgstVal": 1200,'
//         + '   "IgstVal": 0,     '
//         + '    "CesVal": 0,      '
//         + '    "StCesVal": 0,     '
//         + '    "CesNonAdVal": 0,   '
//         + '    "Disc": 0,           '
//         + '    "OthChrg": 0,         '
//         + '    "TotInvVal": 12400     '
//         + ' },                         '
//         + '  "ItemList": [              '
//         + '    {                         '
//         + '      "PrdNm": "WHEAT AND MESLIN",'
//         + '      "PrdDesc": "WHEAT AND MESLIN",'
//         + '      "HsnCd": "1001",'
//          + '     "Barcde": "1212",'
//         + '      "Qty": 2,         '
//         + '      "FreeQty": 1,      '
//         + '      "Unit": "BAG",      '
//         + '      "UnitPrice": 100,    '
//         + '      "TotAmt": 200,        '
//         + '      "Discount": 5,         '
//         + '      "OthChrg": 10,          '
//         + '      "AssAmt": 205,           '
//         + '      "SgstRt": 1,              '
//           + '    "CgstRt": 1,               '
//          + '     "IgstRt": 0,                '
//         + '      "CesRt": 1,                  '
//          + '     "CesNonAdval": 10,            '
//         + '      "StateCes": 2,                 '
//         + '      "TotItemVal": 225.25,           '
//         + '      "BchDtls": {                     '
//         + '        "Nm": "aaa",                    '
//         + '        "ExpDt": "01/02/2020",           '
//         + '        "WrDt": "20/02/2020"'
//         + '      }                                    '
//         + '    }                                       '
//         + '  ]'
//         + '}');
//     end;

//     // [Scope('Internal')]
//     procedure JsonReturn_Xmlport(): Text
//     begin

//         EXIT('Test');
//     end;

//     [Scope('Internal')]
//     procedure GetServiceProtol()
//     var
//         SecurityProtocol: DotNet ServicePointManager;
//     begin
//         //###############################------Do Not delete (Below error resolved)------###############################//
//         //------------------HTTPS: Authentication failed because the remote party has closed the transport stream
//         SecurityProtocol := SecurityProtocol.SecurityProtocol(SecurityProtocol.SecurityProtocol.Tls12);
//         //SecurityProtocolType.Tls12 | SecurityProtocolType.Tls11 | SecurityProtocolType.Tls);
//         //###############################------Do Not delete (Below error resolved)------###############################//
//     end;

//     [Scope('Internal')]
//     procedure DecrytedJsonForIRN()
//     begin
//     end;

//     [Scope('Internal')]
//     procedure CancelIRN_Govt(Irn: Text; CnlRsn: Text; CnlRem: Text; AuthToken: Text; Sek: Text; var CancelDate: Text; Client_ID: Text; Client_Secret: Text; Gstin: Text; user_name: Text)
//     var
//         Token: Label 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzY29wZSI6WyJnc3AiXSwiZXhwIjoxNTY2ODEzMzUwLCJhdXRob3JpdGllcyI6WyJST0xFX1NCX0VfQVBJX0dTVF9SRVRVUk5TIiwiUk9MRV9TQl9FX0FQSV9FV0IiXSwianRpIjoiYjlhNDUxZWEtNzZkOC00N2U3LTg2ZDktNzJhMTk2MjM2MmNhIiwiY2xpZW50X2lkIjoiRTRCMTcyNDMzNkE5NDI5Q0ExQjM4M0ZEODAzMjBCOEYifQ.1BGkFnecJeY0aaQveGdadj9zU5iRe4qaMJ81HKzKOh8';
//         HttpClient: DotNet HttpClient;
//         URI: DotNet Uri;
//         ReqHdr: DotNet HttpRequestHeaders;
//         HttpStringContent: DotNet StringContent;
//         txtJsonResult: Text;
//         HttpResponseMessage: DotNet HttpResponseMessage;
//         JObject: DotNet JObject;
//         Encoding: DotNet Encoding;
//         txtSuccess: Text;
//         txtJsonResponse: Text;
//         txtResult: Text;
//         txtJsonRequest: Text;
//         TextAppKey: Label 'dN+eAtmvwlz/2rsFe5dXkTps08mMko5Q3uvRsYGIPaT9/BcsfwlR8vnuz47VBRooif2Z9wnCUogApf28IRb91OMPs81U9ON7uvE9qyWFhM+8gBj6kFlwj9oBYfRAiO8Ht8YEqXFs+ZCQkFIu3PsvfKl26w1j8xj1HcaPYeVhchJtvp/zBuo8Uk9fwFDeZRjpJwgnJwLw/wx5O2sydhuUm7srI/FIWZVch2+n9TMRueK4twHm/m7xEQQl3k4kmZTguYa9FmsSRb0HDhtqQsOfz7pB7wm6oVzJR01FKn8fTx2diuZSSy6ycc5o6xM65Vj5EkeDeglAcCXTKYP5jE1b4A==';
//         byteAppKey: DotNet Byte;
//         ErrorDetails: Text;
//         ErrorMessage: Text;
//         ErrorDetailsPos1: Integer;
//         ErrorDetailsPos2: Integer;
//         dtJSONConvertor: DotNet JsonConvert;
//         txtData: Text;
//         ConvertCode: DotNet Convert;
//     begin
//         CLEARALL;
//         GetServiceProtol;
//         GetAppkey := GetAppkey.eInv;
//         byteAppKey := GetAppkey.generateSecureKey();

//         txtJsonRequest := CreateJsonCancelIRN(Irn, CnlRsn, CnlRem);
//         //MESSAGE('Data1 = ' + txtJsonRequest);

//         txtJsonRequest := GetAppkey.Base64Encode(txtJsonRequest);
//         txtJsonRequest := GetAppkey.EncryptBySymmetricKey(txtJsonRequest, Sek);
//         txtJsonRequest := CancelIRNData1 + txtJsonRequest + Data2;

//         //MESSAGE('Data = ' + txtJsonRequest);

//         HttpClient := HttpClient.HttpClient;
//         URI := URI.Uri(CancelIRNURL);
//         HttpClient.BaseAddress(URI);
//         HttpClient.DefaultRequestHeaders.Add('Client_ID', Client_ID);
//         HttpClient.DefaultRequestHeaders.Add('Client_Secret', Client_Secret);
//         HttpClient.DefaultRequestHeaders.Add('Gstin', Gstin);
//         HttpClient.DefaultRequestHeaders.Add('user_name', user_name);
//         HttpClient.DefaultRequestHeaders.Add('AuthToken', AuthToken);
//         HttpStringContent := HttpStringContent.StringContent(txtJsonRequest, Encoding.UTF8, 'application/json');
//         HttpResponseMessage := HttpClient.PostAsync(CancelIRNURL, HttpStringContent).Result;
//         txtJsonResponse := HttpResponseMessage.Content.ReadAsStringAsync().Result;

//         //MESSAGE('txtJsonResponse1  = ' + txtJsonResponse);

//         JObject := JObject.JObject;
//         JObject := JObject.Parse(txtJsonResponse);
//         JObject := JObject.GetValue('Status');
//         IF JObject.ToString = '0' THEN BEGIN
//             JObject := JObject.JObject;
//             JObject := JObject.Parse(txtJsonResponse);
//             JObject := JObject.GetValue('ErrorDetails');

//             ErrorDetails := JObject.ToString;
//             //MESSAGE('ErrorDetails : ' +ErrorDetails);

//             ErrorDetailsPos1 := STRPOS(ErrorDetails, '{');
//             ErrorDetailsPos2 := STRPOS(ErrorDetails, '}');
//             ErrorDetails := COPYSTR(ErrorDetails, ErrorDetailsPos1 + 1, ErrorDetailsPos2 - 1);
//             ErrorDetailsPos2 := STRPOS(ErrorDetails, '}');
//             ErrorDetails := '{' + COPYSTR(ErrorDetails, 1, ErrorDetailsPos2 - 1) + '}';
//             //MESSAGE('ErrorDetails123 : ' +ErrorDetails);

//             JObject := JObject.JObject;
//             JObject := JObject.Parse(ErrorDetails);
//             JObject := JObject.GetValue('ErrorMessage');
//             ErrorMessage := JObject.ToString;

//             ERROR(ErrorMessage)
//         END ELSE BEGIN
//             JObject := JObject.JObject;
//             JObject := JObject.Parse(txtJsonResponse);
//             JObject := JObject.GetValue('Data');
//             txtResult := JObject.ToString;

//             txtResult := GetAppkey.DecryptBySymmetricKey(txtResult, ConvertCode.FromBase64String(Sek));
//             txtResult := GetAppkey.Base64Decode(txtResult);

//             JObject := JObject.JObject;
//             JObject := JObject.Parse(txtResult);
//             JObject := JObject.GetValue('CancelDate');
//             CancelDate := JObject.ToString;

//             MESSAGE('IRN canceled successfully')
//         END;
//     end;

//     local procedure CreateJsonCancelIRN_Govt(Irn: Text; CnlRsn: Text; CnlRem: Text): Text
//     var
//         StringBuilder: DotNet StringBuilder;
//         StringWriter: DotNet StringWriter;
//         JSON: DotNet String;
//         JSONTextWriter: DotNet JsonTextWriter;
//         JSONTextWriter2: DotNet JsonWriter;
//     begin
//         StringBuilder := StringBuilder.StringBuilder;
//         StringWriter := StringWriter.StringWriter(StringBuilder);
//         JSONTextWriter := JSONTextWriter.JsonTextWriter(StringWriter);


//         JSONTextWriter.WriteStartObject;

//         CreateJsonAttributeGetToken('Irn', Irn, JSONTextWriter, FALSE);
//         CreateJsonAttributeGetToken('CnlRsn', CnlRsn, JSONTextWriter, FALSE);
//         CreateJsonAttributeGetToken('CnlRem', CnlRem, JSONTextWriter, FALSE);
//         JSONTextWriter.WriteEndObject;

//         EXIT(StringBuilder.ToString);
//     end;

//     [Scope('Internal')]
//     procedure GetIRNDetails_Govt(AuthToken: Text; Sek: Text; Irn: Text; Client_ID: Text; Client_Secret: Text; Gstin: Text; user_name: Text)
//     var
//         HttpClient: DotNet HttpClient;
//         URI: DotNet Uri;
//         ReqHdr: DotNet HttpRequestHeaders;
//         HttpStringContent: DotNet StringContent;
//         txtJsonResult: Text;
//         HttpResponseMessage: DotNet HttpResponseMessage;
//         JObject: DotNet JObject;
//         Encoding: DotNet Encoding;
//         txtJsonResponse: Text;
//         txtResult: Text;
//         txtJsonRequest: Text;
//         FileName: Text;
//         TestFile: File;
//         FileMgt: Codeunit "419";
//         MyOutStream: OutStream;
//         byteAppKey: DotNet Byte;
//         ErrorDetails: Text;
//         ErrorMessage: Text;
//         ErrorDetailsPos1: Integer;
//         ErrorDetailsPos2: Integer;
//         dtJSONConvertor: DotNet JsonConvert;
//         txtData: Text;
//         ConvertCode: DotNet Convert;
//     begin
//         CLEARALL;
//         HttpClient := HttpClient.HttpClient;

//         URI := URI.Uri(GetIrnDetailsText + Irn);
//         HttpClient.BaseAddress(URI);
//         HttpClient.DefaultRequestHeaders.Add('Client_ID', Client_ID);
//         HttpClient.DefaultRequestHeaders.Add('Client_Secret', Client_Secret);
//         HttpClient.DefaultRequestHeaders.Add('Gstin', Gstin);
//         HttpClient.DefaultRequestHeaders.Add('user_name', user_name);
//         HttpClient.DefaultRequestHeaders.Add('AuthToken', AuthToken);
//         HttpStringContent := HttpStringContent.StringContent(txtJsonRequest, Encoding.UTF8, 'application/json');
//         HttpResponseMessage := HttpClient.GetAsync(URI).Result;
//         txtJsonResponse := HttpResponseMessage.Content.ReadAsStringAsync().Result;

//         JObject := JObject.JObject;
//         JObject := JObject.Parse(txtJsonResponse);
//         JObject := JObject.GetValue('Status');
//         IF JObject.ToString = '0' THEN BEGIN
//             JObject := JObject.JObject;
//             JObject := JObject.Parse(txtJsonResponse);
//             JObject := JObject.GetValue('ErrorDetails');
//             ErrorDetails := JObject.ToString;
//             //MESSAGE('ErrorDetails : ' +ErrorDetails);

//             ErrorDetailsPos1 := STRPOS(ErrorDetails, '{');
//             ErrorDetailsPos2 := STRPOS(ErrorDetails, '}');
//             ErrorDetails := COPYSTR(ErrorDetails, ErrorDetailsPos1 + 1, ErrorDetailsPos2 - 1);
//             ErrorDetailsPos2 := STRPOS(ErrorDetails, '}');
//             ErrorDetails := '{' + COPYSTR(ErrorDetails, 1, ErrorDetailsPos2 - 1) + '}';
//             //MESSAGE('ErrorDetails123 : ' +ErrorDetails);

//             JObject := JObject.JObject;
//             JObject := JObject.Parse(ErrorDetails);
//             JObject := JObject.GetValue('ErrorMessage');
//             ErrorMessage := JObject.ToString;

//             ERROR(ErrorMessage)
//         END ELSE BEGIN
//             JObject := JObject.JObject;
//             JObject := JObject.Parse(txtJsonResponse);
//             JObject := JObject.GetValue('Data');
//             txtResult := JObject.ToString;

//             txtResult := GetAppkey.DecryptBySymmetricKey(txtResult, ConvertCode.FromBase64String(Sek));
//             txtResult := GetAppkey.Base64Decode(txtResult);

//         END;


//         //Save in notepad Begin
//         FileName := FileMgt.SaveFileDialog('Window Title', '.txt', 'Text files *.txt|*.txt');
//         IF FileName = '' THEN
//             EXIT;
//         TestFile.CREATE(FileName);
//         TestFile.CREATEOUTSTREAM(MyOutStream);
//         MyOutStream.WRITETEXT(txtResult);
//         HYPERLINK(FileName);
//         //Save in notepad End
//     end;

//     //[Scope('Internal')]
//     procedure GetGSTINDetails_Govt(AuthToken: Text; Sek: Text; Client_ID: Text; Client_Secret: Text; Gstin: Text; user_name: Text; GSTRegNo: Text; ShowMsg: Boolean)
//     var
//         HttpClient: DotNet HttpClient;
//         URI: DotNet Uri;
//         ReqHdr: DotNet HttpRequestHeaders;
//         HttpStringContent: DotNet StringContent;
//         txtJsonResult: Text;
//         HttpResponseMessage: DotNet HttpResponseMessage;
//         JObject: DotNet JObject;
//         Encoding: DotNet Encoding;
//         txtJsonResponse: Text;
//         txtResult: Text;
//         txtJsonRequest: Text;
//         FileName: Text;
//         TestFile: File;
//         FileMgt: Codeunit "419";
//         MyOutStream: OutStream;
//         byteAppKey: DotNet Byte;
//         ErrorDetails: Text;
//         ErrorMessage: Text;
//         ErrorDetailsPos1: Integer;
//         ErrorDetailsPos2: Integer;
//         dtJSONConvertor: DotNet JsonConvert;
//         txtData: Text;
//         ConvertCode: DotNet Convert;
//     begin

//         CLEARALL;
//         HttpClient := HttpClient.HttpClient;

//         URI := URI.Uri(GetGSTINDetailsText + GSTRegNo);
//         HttpClient.BaseAddress(URI);
//         HttpClient.DefaultRequestHeaders.Add('Client_ID', Client_ID);
//         HttpClient.DefaultRequestHeaders.Add('Client_Secret', Client_Secret);
//         HttpClient.DefaultRequestHeaders.Add('Gstin', Gstin);
//         HttpClient.DefaultRequestHeaders.Add('user_name', user_name);
//         HttpClient.DefaultRequestHeaders.Add('AuthToken', AuthToken);
//         HttpResponseMessage := HttpClient.GetAsync(URI).Result;
//         txtJsonResponse := HttpResponseMessage.Content.ReadAsStringAsync().Result;

//         JObject := JObject.JObject;
//         JObject := JObject.Parse(txtJsonResponse);
//         JObject := JObject.GetValue('Status');
//         IF JObject.ToString = '0' THEN BEGIN
//             JObject := JObject.JObject;
//             JObject := JObject.Parse(txtJsonResponse);
//             JObject := JObject.GetValue('ErrorDetails');

//             ErrorDetails := JObject.ToString;
//             ErrorDetailsPos1 := STRPOS(ErrorDetails, '{');
//             ErrorDetailsPos2 := STRPOS(ErrorDetails, '}');
//             ErrorDetails := COPYSTR(ErrorDetails, ErrorDetailsPos1 + 1, ErrorDetailsPos2 - 1);
//             ErrorDetailsPos2 := STRPOS(ErrorDetails, '}');
//             ErrorDetails := '{' + COPYSTR(ErrorDetails, 1, ErrorDetailsPos2 - 1) + '}';

//             JObject := JObject.JObject;
//             JObject := JObject.Parse(ErrorDetails);
//             JObject := JObject.GetValue('ErrorMessage');
//             ErrorMessage := JObject.ToString;

//             ERROR(ErrorMessage)
//         END ELSE BEGIN
//             IF ShowMsg THEN
//                 MESSAGE('GST Registrarion No. is valid');
//             JObject := JObject.JObject;
//             JObject := JObject.Parse(txtJsonResponse);
//             JObject := JObject.GetValue('Data');
//             txtResult := JObject.ToString;

//             txtResult := GetAppkey.DecryptBySymmetricKey(txtResult, ConvertCode.FromBase64String(Sek));
//             txtResult := GetAppkey.Base64Decode(txtResult);

//         END;


//         //Save in notepad Begin
//         IF NOT CONFIRM('Do you want to save details to notepad?') THEN
//             EXIT;
//         FileName := FileMgt.SaveFileDialog('Window Title', '.txt', 'Text files *.txt|*.txt');
//         IF FileName = '' THEN
//             EXIT;
//         TestFile.CREATE(FileName);
//         TestFile.CREATEOUTSTREAM(MyOutStream);
//         MyOutStream.WRITETEXT(txtResult);
//         HYPERLINK(FileName);
//     end;

//     local procedure ReturnGenEBWJson(var TempBlob2: Record 99008535; DocNo: Code[20])
//     var
//         //[RunOnClient]
//         XMLDoc: DotNet XmlDocument;
//         //[RunOnClient]
//         JSONConvert: DotNet JsonConvert;
//         myInStream: InStream;
//         myJson: Text;
//         JSONFormatting: DotNet Formatting;
//         myOutStream: OutStream;
//         GSTLedgerEntry: Record "16418";
//         lvTempBlob: Record 99008535 temporary;
//     begin
//         XMLDoc := XMLDoc.XmlDocument;
//         //
//         GSTLedgerEntry.SETFILTER("Document No.", DocNo);
//         IF GSTLedgerEntry.FINDFIRST THEN BEGIN
//             lvTempBlob."Primary Key" := 21;
//             lvTempBlob.INSERT;
//             lvTempBlob.Blob.CREATEOUTSTREAM(myOutStream);
//             XMLPORT.EXPORT(50016, myOutStream, GSTLedgerEntry);
//             lvTempBlob.MODIFY;
//         END;
//         //Temp
//         XMLDoc.LoadXml(ReadAsText('', lvTempBlob));
//         //XMLDoc.Load('E:\Ysr\Generate EwayBill2.xml');
//         myJson := JSONConvert.SerializeXmlNode(XMLDoc.DocumentElement, JSONFormatting.Indented, TRUE);

//         TempBlob2.INIT;
//         TempBlob2.Blob.CREATEOUTSTREAM(myOutStream, TEXTENCODING::UTF8);
//         myOutStream.WRITETEXT(myJson);
//     end;

//     [Scope('Internal')]
//     procedure "--Blob Begin"()
//     begin
//     end;

//     [Scope('Internal')]
//     procedure WriteAsText(Content: Text; prtempBlob: Record "99008535")
//     var
//         OutStr: OutStream;
//     begin
//         CLEAR(prtempBlob.Blob);
//         IF Content = '' THEN
//             EXIT;
//         prtempBlob.Blob.CREATEOUTSTREAM(OutStr);
//         OutStr.WRITETEXT(Content);
//     end;

//     [Scope('Internal')]
//     procedure ReadAsText(LineSeparator: Text; prtempBlob: Record "99008535") Content: Text
//     var
//         InStream: InStream;
//         ContentLine: Text;
//     begin
//         prtempBlob.Blob.CREATEINSTREAM(InStream);

//         InStream.READTEXT(Content);
//         WHILE NOT InStream.EOS DO BEGIN
//             InStream.READTEXT(ContentLine);
//             Content += LineSeparator + ContentLine;
//         END;
//     end;

//     [Scope('Internal')]
//     procedure "--Blob End"()
//     begin
//     end;

//     [Scope('Internal')]
//     procedure GetHashOfIRN(AuthToken: Text; Sek: Text; var AckNo: Text; var AckDt: Text; var Irn: Text; var SignedInvoice: Text; var SignedQRCode: Text; Client_ID: Text; Client_Secret: Text)
//     var
//         Token: Label 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzY29wZSI6WyJnc3AiXSwiZXhwIjoxNTY2ODEzMzUwLCJhdXRob3JpdGllcyI6WyJST0xFX1NCX0VfQVBJX0dTVF9SRVRVUk5TIiwiUk9MRV9TQl9FX0FQSV9FV0IiXSwianRpIjoiYjlhNDUxZWEtNzZkOC00N2U3LTg2ZDktNzJhMTk2MjM2MmNhIiwiY2xpZW50X2lkIjoiRTRCMTcyNDMzNkE5NDI5Q0ExQjM4M0ZEODAzMjBCOEYifQ.1BGkFnecJeY0aaQveGdadj9zU5iRe4qaMJ81HKzKOh8';
//         HttpClient: DotNet HttpClient;
//         URI: DotNet Uri;
//         ReqHdr: DotNet HttpRequestHeaders;
//         HttpStringContent: DotNet StringContent;
//         txtJsonResult: Text;
//         HttpResponseMessage: DotNet HttpResponseMessage;
//         JObject: DotNet JObject;
//         Encoding: DotNet Encoding;
//         txtSuccess: Text;
//         txtJsonResponse: Text;
//         txtResult: Text;
//         txtJsonRequest: Text;
//         TextAppKey: Label 'dN+eAtmvwlz/2rsFe5dXkTps08mMko5Q3uvRsYGIPaT9/BcsfwlR8vnuz47VBRooif2Z9wnCUogApf28IRb91OMPs81U9ON7uvE9qyWFhM+8gBj6kFlwj9oBYfRAiO8Ht8YEqXFs+ZCQkFIu3PsvfKl26w1j8xj1HcaPYeVhchJtvp/zBuo8Uk9fwFDeZRjpJwgnJwLw/wx5O2sydhuUm7srI/FIWZVch2+n9TMRueK4twHm/m7xEQQl3k4kmZTguYa9FmsSRb0HDhtqQsOfz7pB7wm6oVzJR01FKn8fTx2diuZSSy6ycc5o6xM65Vj5EkeDeglAcCXTKYP5jE1b4A==';
//         byteAppKey: DotNet Byte;
//         ErrorDetails: Text;
//         ErrorMessage: Text;
//         ErrorDetailsPos1: Integer;
//         ErrorDetailsPos2: Integer;
//         ConvertCode: DotNet Convert;
//     begin
//         CLEARALL;

//         GetServiceProtol;
//         GetAppkey := GetAppkey.eInv;
//         byteAppKey := GetAppkey.generateSecureKey();
//         txtResult := GetAppkey.DecryptBySymmetricKey(txtResult, ConvertCode.FromBase64String(Sek));
//         txtResult := GetAppkey.Base64Decode(txtResult);
//     end;

//     [Scope('Internal')]
//     procedure VerifyVendorIRNDetails(AuthToken: Text; Sek: Text; Irn: Text; Client_ID: Text; Client_Secret: Text; Gstin: Text; user_name: Text)
//     var
//         HttpClient: DotNet HttpClient;
//         URI: DotNet Uri;
//         ReqHdr: DotNet HttpRequestHeaders;
//         HttpStringContent: DotNet StringContent;
//         txtJsonResult: Text;
//         HttpResponseMessage: DotNet HttpResponseMessage;
//         JObject: DotNet JObject;
//         Encoding: DotNet Encoding;
//         txtJsonResponse: Text;
//         txtResult: Text;
//         txtJsonRequest: Text;
//         FileName: Text;
//         TestFile: File;
//         FileMgt: Codeunit "419";
//         MyOutStream: OutStream;
//         byteAppKey: DotNet Byte;
//         ErrorDetails: Text;
//         ErrorMessage: Text;
//         ErrorDetailsPos1: Integer;
//         ErrorDetailsPos2: Integer;
//         dtJSONConvertor: DotNet JsonConvert;
//         txtData: Text;
//         ConvertCode: DotNet Convert;
//     begin
//         CLEARALL;
//         HttpClient := HttpClient.HttpClient;

//         URI := URI.Uri(GetIrnDetailsText + Irn);
//         HttpClient.BaseAddress(URI);
//         HttpClient.DefaultRequestHeaders.Add('Client_ID', Client_ID);
//         HttpClient.DefaultRequestHeaders.Add('Client_Secret', Client_Secret);
//         HttpClient.DefaultRequestHeaders.Add('Gstin', Gstin);
//         HttpClient.DefaultRequestHeaders.Add('user_name', user_name);
//         HttpClient.DefaultRequestHeaders.Add('AuthToken', AuthToken);
//         HttpStringContent := HttpStringContent.StringContent(txtJsonRequest, Encoding.UTF8, 'application/json');
//         HttpResponseMessage := HttpClient.GetAsync(URI).Result;
//         txtJsonResponse := HttpResponseMessage.Content.ReadAsStringAsync().Result;

//         JObject := JObject.JObject;
//         JObject := JObject.Parse(txtJsonResponse);
//         JObject := JObject.GetValue('Status');
//         IF JObject.ToString = '0' THEN BEGIN

//             ERROR('Invalid IRN')
//         END ELSE BEGIN
//             MESSAGE('IRN is valid')
//         END;
//     end;

//     [Scope('Internal')]
//     procedure DecodeQRCodeAndSign(String: Text) DecodedString: Text
//     begin
//         GetAppkey := GetAppkey.eInv;
//         EXIT(GetAppkey.Decode(String));
//     end;

//     [Scope('Internal')]
//     procedure DecodeQrCode()
//     begin
//         GetAppkey := GetAppkey.eInv;


//         //EXIT(GetAppkey.Decode(String));
//     end;

//     [Scope('Internal')]
//     procedure GetQr(String: Text) DecodedQr: Text
//     var
//         Token: Label 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzY29wZSI6WyJnc3AiXSwiZXhwIjoxNTY2ODEzMzUwLCJhdXRob3JpdGllcyI6WyJST0xFX1NCX0VfQVBJX0dTVF9SRVRVUk5TIiwiUk9MRV9TQl9FX0FQSV9FV0IiXSwianRpIjoiYjlhNDUxZWEtNzZkOC00N2U3LTg2ZDktNzJhMTk2MjM2MmNhIiwiY2xpZW50X2lkIjoiRTRCMTcyNDMzNkE5NDI5Q0ExQjM4M0ZEODAzMjBCOEYifQ.1BGkFnecJeY0aaQveGdadj9zU5iRe4qaMJ81HKzKOh8';
//         HttpClient: DotNet HttpClient;
//         URI: DotNet Uri;
//         ReqHdr: DotNet HttpRequestHeaders;
//         HttpStringContent: DotNet StringContent;
//         txtJsonResult: Text;
//         HttpResponseMessage: DotNet HttpResponseMessage;
//         JObject: DotNet JObject;
//         Encoding: DotNet Encoding;
//         txtSuccess: Text;
//         txtJsonResponse: Text;
//         txtResult: Text;
//         txtJsonRequest: Text;
//         TextAppKey: Label 'dN+eAtmvwlz/2rsFe5dXkTps08mMko5Q3uvRsYGIPaT9/BcsfwlR8vnuz47VBRooif2Z9wnCUogApf28IRb91OMPs81U9ON7uvE9qyWFhM+8gBj6kFlwj9oBYfRAiO8Ht8YEqXFs+ZCQkFIu3PsvfKl26w1j8xj1HcaPYeVhchJtvp/zBuo8Uk9fwFDeZRjpJwgnJwLw/wx5O2sydhuUm7srI/FIWZVch2+n9TMRueK4twHm/m7xEQQl3k4kmZTguYa9FmsSRb0HDhtqQsOfz7pB7wm6oVzJR01FKn8fTx2diuZSSy6ycc5o6xM65Vj5EkeDeglAcCXTKYP5jE1b4A==';
//         byteAppKey: DotNet Byte;
//         ErrorDetails: Text;
//         ErrorMessage: Text;
//         ErrorDetailsPos1: Integer;
//         ErrorDetailsPos2: Integer;
//         ConvertCode: DotNet Convert;
//         intstrpos: Integer;
//         SubString: Label '"data"';
//         SubString2: Label '"iss": "NIC"';

// };
//         intstrpos2: Integer;
//         AddComma: Label '}{';
//         AddedComma: Label '},{';
//         QrString: Text;
//     begin
//         GetAppkey :=  GetAppkey.eInv;
//         String  :=  GetAppkey.Decode(String);

//         intstrpos  :=  STRPOS(String, SubString)  -5;

//         //ReplaceString(String, AddComma, AddedComma);


//         intstrpos2  :=  STRPOS(String, SubString2);
//         //String  :=  DELCHR(String,  '=',  SubString2);

//         String  :=  COPYSTR(String, intstrpos,  STRLEN(String));


//           JObject :=  JObject.JObject;
//           JObject := JObject.Parse(String);
//           JObject :=  JObject.GetValue('data');
//           txtResult  :=  JObject.ToString;

//           JObject :=  JObject.JObject;
//           JObject := JObject.Parse(txtResult);
//           JObject :=  JObject.GetValue('SellerGstin');
//           QrString  :=  JObject.ToString;

//           JObject :=  JObject.JObject;
//           JObject := JObject.Parse(txtResult);
//           JObject :=  JObject.GetValue('BuyerGstin');
//           QrString  :=  QrString  +','+ JObject.ToString;

//           JObject :=  JObject.JObject;
//           JObject := JObject.Parse(txtResult);
//           JObject :=  JObject.GetValue('DocNo');
//           QrString  :=  QrString  +','+ JObject.ToString;

//           JObject :=  JObject.JObject;
//           JObject := JObject.Parse(txtResult);
//           JObject :=  JObject.GetValue('DocDt');
//           QrString  :=  QrString  +','+ JObject.ToString;

//           JObject :=  JObject.JObject;
//           JObject := JObject.Parse(txtResult);
//           JObject :=  JObject.GetValue('TotInvVal');
//           QrString  :=  QrString  +','+ JObject.ToString;

//           JObject :=  JObject.JObject;
//           JObject := JObject.Parse(txtResult);
//           JObject :=  JObject.GetValue('ItemCnt');
//           QrString  :=  QrString  +','+ JObject.ToString;

//           JObject :=  JObject.JObject;
//           JObject := JObject.Parse(txtResult);
//           JObject :=  JObject.GetValue('MainHsnCode');
//           QrString  :=  QrString  +','+ JObject.ToString;

//           JObject :=  JObject.JObject;
//           JObject := JObject.Parse(txtResult);
//           JObject :=  JObject.GetValue('Irn');
//           QrString  :=  QrString  +','+ JObject.ToString;

//         EXIT(QrString);
//     end;

//     [Scope('Internal')]
//     procedure ReplaceString(String: Text;FindWhat: Text;ReplaceWith: Text) NewString: Text
//     begin
//         WHILE STRPOS(String,FindWhat) > 0 DO
//           String := DELSTR(String,STRPOS(String,FindWhat)) + ReplaceWith + COPYSTR(String,STRPOS(String,FindWhat) + STRLEN(FindWhat));
//         NewString := String;
//     end;

//     [Scope('Internal')]
//     procedure FindLastComma(String: Text): Integer
//     var
//         i: Integer;
//     begin
//         FOR i := 1 TO STRLEN(String) DO BEGIN
//           IF String[STRLEN(String)+1-i] = ',' THEN
//             EXIT(STRLEN(String)-i);
//         END;
//     end;

//     [Scope('Internal')]
//     procedure DynamicJsonReturn(txtDocNo: Text) IRNJson: Text
//     var
//         NoSeriesMgt: Codeunit "396";
//         cdNo: Code[20];
//         cdNoSeries: Code[20];
//         Catg: Text;
//         RegRev: Text;
//         Typ: Text;
//         DocType: Text;
//         DocDate: Text;
//         LocRec: Record "14";
//         StateRec: Record "13762";
//         CustomerRec: Record "18";
//         StateCd: Integer;
//         StateRec2: Record "13762";
//         AssVal: Decimal;
//         CgstVal: Decimal;
//         SgstVal: Decimal;
//         IgstVal: Decimal;
//         CesVal: Decimal;
//         StCesVal: Decimal;
//         CesNonAdval: Decimal;
//         Disc: Decimal;
//         OthChrg: Decimal;
//         TotInvVal: Decimal;
//         Trsnsdtls: Text;
//         DocDtls: Text;
//         SellerDtls: Text;
//         BuyerDtls: Text;
//         ValDtls: Text;
//         ItemListDtls: Text;
//         DispDtls: Text;
//         ShipDtls: Text;
//         TaxSchema: Text;
//         ItemListValuesDtls: Text;
//         SalesInvoiceLine: Record "113";
//         SalesCrMemoLine: Record "115";
//         AssAmt: Decimal;
//         CgstRt: Decimal;
//         SgstRt: Decimal;
//         IgstRt: Decimal;
//         CesRt: Decimal;
//         CesNonAdval2: Decimal;
//         StateCes: Decimal;
//         FreeQty: Decimal;
//         SNo: Integer;
//         StateRec3: Record "13762";
//         Shiptoadd: Record "222";
//         ValueEntry: Record "5802";
//         ItemLedgerEntry: Record "32";
//         ValueEntryRelation: Record "6508";
//         ItemTrackingManagement: Codeunit "6500";
//         InvoiceRowID: Text[250];
//         BchDtls: Text;
//         TotalSGSTAmt: Decimal;
//         TotalCGSTAmt: Decimal;
//         TotalIGSTAmt: Decimal;
//         ISServc: Text;
//         ShipGSTIN: Text;
//         ShipStcd: Text;
//         ShipPincode: Text;
//         ItemRec: Record "27";
//         recUnitofMeasure: Record "204";
//         qtyUnit: Code[10];
//         ShipToAddress: Record "222";
//         PayDtls: Text;
//         CustomerRec2: Record "18";
//         BankAccount: Record "270";
//         Ewbdtls: Text;
//         TranporterRec: Record "50046";
//         ShipMethodRec: Record "10";
//         ExpDtls: Text;
//         RefDtls: Text;
//         AddlDocDtls: Text;
//         CustLedEntry: Record "21";
//         PaymentDue: Decimal;
//         SellerPhoneNo: Text;
//         SellerEmail: Text;
//         BuyerPhoneNo: Text;
//         BuyerEmail: Text;
//         BuyerGstin: Text[20];
//         BuyerPos: Text[20];
//         BuyerStcd: Text[20];
//         BuyerPincode: Text[20];
//         CurrExchRate: Record "330";
//         TotAmt: Decimal;
//         TotalItemVal: Decimal;
//         HSNRec: Record "16411";
//         GstSetup: Record "16408";
//         GSTRate: Decimal;
//         DiscAmount: Decimal;
//         TDSTCSAmount: Decimal;
//         CompanyInfo: Record "79";
//         BatchDetailsName: Text;
//     begin

//         SNo := 0;
//         InitializeVariables;
//         SetSalesInvHeader(txtDocNo); // DJ 28/02/20
//         SetCrMemoHeader(txtDocNo); // DJ 28/02/20
//         IF CompanyInfo.GET THEN; //AR05NOV20

//         IF IsInvoice THEN BEGIN
//           DocType := 'INV';
//           DocDate:=FORMAT(SalesInvoiceHeader."Posting Date",0,'<Day,2>/<Month,2>/<Year4>');
//           IF LocRec.GET(SalesInvoiceHeader."Location Code") THEN;
//           IF StateRec.GET(LocRec."State Code") THEN;
//           CustomerRec.GET(SalesInvoiceHeader."Sell-to Customer No.");
//           CustomerRec2.GET(SalesInvoiceHeader."Bill-to Customer No.");
//           //IF BankAccount.GET(SalesInvoiceHeader."Bank Account") THEN;
//           IF TranporterRec.GET(SalesInvoiceHeader."Transporter Code") THEN;
//           IF ShipMethodRec.GET(SalesInvoiceHeader."Shipment Method Code") THEN;
//           CustLedEntry.RESET;
//           CustLedEntry.SETRANGE(CustLedEntry."Document Type",CustLedEntry."Document Type"::Invoice);
//           CustLedEntry.SETRANGE("Document No.",SalesInvoiceHeader."No.");
//           IF CustLedEntry.FINDFIRST THEN BEGIN
//             CustLedEntry.CALCFIELDS(CustLedEntry."Remaining Amt. (LCY)");
//             PaymentDue := CustLedEntry."Remaining Amt. (LCY)";
//           END;
//           IF SalesInvoiceHeader."Ship-to Code" = '' THEN BEGIN
//             IF StateRec2.GET(CustomerRec."State Code") THEN;
//           END ELSE BEGIN
//             ShipToAddress.GET(SalesInvoiceHeader."Sell-to Customer No.",SalesInvoiceHeader."Ship-to Code");
//             IF StateRec2.GET(ShipToAddress.State) THEN;
//           END;

//           IF SalesInvoiceHeader."Ship-to Code" <> '' THEN BEGIN
//             Shiptoadd.GET(SalesInvoiceHeader."Sell-to Customer No.",SalesInvoiceHeader."Ship-to Code");
//             IF StateRec3.GET(Shiptoadd.State) THEN;
//             ShipGSTIN := Shiptoadd."GST Registration No.";
//            END ELSE BEGIN
//              IF StateRec3.GET(SalesInvoiceHeader.State) THEN;
//              ShipGSTIN := CustomerRec."GST Registration No."
//            END;

//           IF (SalesInvoiceHeader."GST Customer Type" = SalesInvoiceHeader."GST Customer Type"::Registered) THEN BEGIN
//             Catg := 'B2B';
//             RegRev := 'N';
//             BuyerGstin := CustomerRec."GST Registration No.";
//             IF StateRec2.GET(CustomerRec."State Code") THEN;// DJ 16102020
//             BuyerPos := StateRec2."State Code (GST Reg. No.)";
//             BuyerStcd := StateRec2."State Code (GST Reg. No.)";
//             BuyerPincode := CustomerRec."Post Code";
//             ShipPincode := SalesInvoiceHeader."Ship-to Post Code";
//             ShipStcd := StateRec3."State Code (GST Reg. No.)";
//           END
//           ELSE IF (SalesInvoiceHeader."GST Customer Type" = SalesInvoiceHeader."GST Customer Type"::Unregistered) THEN BEGIN
//             Catg := 'B2B';
//             RegRev := 'N';
//             //BuyerGstin := 'URP';
//             BuyerGstin := CustomerRec2."GST Registration No.";
//             ShipGSTIN := 'URP';
//             IF StateRec2.GET(CustomerRec."State Code") THEN;// DJ 16102020
//             BuyerPos := StateRec2."State Code (GST Reg. No.)";
//             BuyerStcd := StateRec2."State Code (GST Reg. No.)";
//             BuyerPincode := CustomerRec."Post Code";
//             ShipPincode := SalesInvoiceHeader."Ship-to Post Code";
//             ShipStcd := StateRec3."State Code (GST Reg. No.)";
//           END
//           ELSE IF SalesInvoiceHeader."GST Customer Type" = SalesInvoiceHeader."GST Customer Type"::Export THEN BEGIN
//             Catg := 'EXPWOP';
//             RegRev := 'N';
//             BuyerGstin := 'URP';
//             BuyerPos := '96';
//             BuyerStcd := '96';
//             BuyerPincode := '999999';
//             ShipGSTIN := 'URP';
//             ShipPincode := '999999';
//             ShipStcd := '96';
//            END
//           ELSE IF SalesInvoiceHeader."GST Customer Type" = SalesInvoiceHeader."GST Customer Type"::"Deemed Export" THEN BEGIN
//             Catg := 'DEXP';
//             RegRev := 'N';
//             /*BuyerGstin := 'URP';
//             BuyerPos := '96';
//             BuyerStcd := '96';
//             BuyerPincode := '999999';
//             ShipGSTIN := 'URP';
//             ShipPincode := '999999';
//             ShipStcd := '96';
//             */
//             BuyerGstin := CustomerRec."GST Registration No.";
//             IF StateRec2.GET(CustomerRec."State Code") THEN;// DJ 16102020
//             BuyerPos := StateRec2."State Code (GST Reg. No.)";
//             BuyerStcd := StateRec2."State Code (GST Reg. No.)";
//             BuyerPincode := CustomerRec."Post Code";
//             ShipPincode := SalesInvoiceHeader."Ship-to Post Code";
//             ShipStcd := StateRec3."State Code (GST Reg. No.)";
//           END
//           ELSE IF (SalesInvoiceHeader."GST Customer Type" = SalesInvoiceHeader."GST Customer Type"::"SEZ Development") OR (SalesInvoiceHeader."GST Customer Type" = SalesInvoiceHeader."GST Customer Type"::"SEZ Unit") THEN BEGIN
//             Catg := 'SEZWOP';
//             RegRev := 'N';
//             BuyerGstin := CustomerRec."GST Registration No.";
//             IF StateRec2.GET(CustomerRec."State Code") THEN;// DJ 16102020
//             BuyerPos := StateRec2."State Code (GST Reg. No.)";
//             BuyerStcd := StateRec2."State Code (GST Reg. No.)";
//             BuyerPincode := CustomerRec."Post Code";
//             ShipPincode := SalesInvoiceHeader."Ship-to Post Code";
//             ShipStcd := StateRec3."State Code (GST Reg. No.)";
//           END;
//         END ELSE BEGIN
//           DocType := 'CRN';
//           DocDate:=FORMAT(SalesCrMemoHeader."Posting Date",0,'<Day,2>/<Month,2>/<Year4>');
//           IF LocRec.GET(SalesCrMemoHeader."Location Code") THEN;
//           IF StateRec.GET(LocRec."State Code") THEN;
//           CustomerRec.GET(SalesCrMemoHeader."Sell-to Customer No.");
//           CustomerRec2.GET(SalesCrMemoHeader."Bill-to Customer No.");
//           //IF BankAccount.GET(SalesCrMemoHeader."Bank Account") THEN;
//           //IF TranporterRec.GET(SalesCrMemoHeader."Transporter Code") THEN;
//           IF ShipMethodRec.GET(SalesCrMemoHeader."Shipment Method Code") THEN;
//           CustLedEntry.RESET;
//           CustLedEntry.SETRANGE(CustLedEntry."Document Type",CustLedEntry."Document Type"::Invoice);
//           CustLedEntry.SETRANGE("Document No.",SalesCrMemoHeader."No.");
//           IF CustLedEntry.FINDFIRST THEN BEGIN
//             CustLedEntry.CALCFIELDS(CustLedEntry."Remaining Amt. (LCY)");
//             PaymentDue := CustLedEntry."Remaining Amt. (LCY)";
//           END;
//           IF SalesCrMemoHeader."Ship-to Code" = '' THEN BEGIN
//             IF StateRec2.GET(CustomerRec."State Code") THEN;
//           END ELSE BEGIN
//             ShipToAddress.GET(SalesCrMemoHeader."Sell-to Customer No.",SalesCrMemoHeader."Ship-to Code");
//             IF StateRec2.GET(ShipToAddress.State) THEN;
//           END;

//           IF SalesCrMemoHeader."Ship-to Code" <> '' THEN BEGIN
//             Shiptoadd.GET(SalesCrMemoHeader."Sell-to Customer No.",SalesCrMemoHeader."Ship-to Code");
//             IF StateRec3.GET(Shiptoadd.State) THEN;
//             ShipGSTIN := Shiptoadd."GST Registration No.";
//            END ELSE BEGIN
//              //IF StateRec3.GET(SalesCrMemoHeader.State) THEN;
//              IF StateRec3.GET(LocRec."State Code") THEN;
//              ShipGSTIN := CustomerRec."GST Registration No."
//            END;

//           IF (SalesCrMemoHeader."GST Customer Type" = SalesCrMemoHeader."GST Customer Type"::Registered) THEN BEGIN
//             Catg := 'B2B';
//             RegRev := 'N';
//             BuyerGstin := CustomerRec."GST Registration No.";
//             IF StateRec2.GET(CustomerRec."State Code") THEN;// DJ 16102020
//             BuyerPos := StateRec2."State Code (GST Reg. No.)";
//             BuyerStcd := StateRec2."State Code (GST Reg. No.)";
//             BuyerPincode := CustomerRec."Post Code";
//             ShipPincode := SalesCrMemoHeader."Ship-to Post Code";
//             ShipStcd := StateRec3."State Code (GST Reg. No.)";
//             //ShipStcd := StateRec2."State Code (GST Reg. No.)"; // DJ 11102020
//           END
//           ELSE IF (SalesCrMemoHeader."GST Customer Type" = SalesCrMemoHeader."GST Customer Type"::Unregistered) THEN BEGIN
//             Catg := 'B2B';
//             RegRev := 'N';
//             BuyerGstin := 'URP';
//             ShipGSTIN := 'URP';
//             IF StateRec2.GET(CustomerRec."State Code") THEN;// DJ 16102020
//             BuyerPos := StateRec2."State Code (GST Reg. No.)";
//             BuyerStcd := StateRec2."State Code (GST Reg. No.)";
//             BuyerPincode := CustomerRec."Post Code";
//             ShipPincode := SalesCrMemoHeader."Ship-to Post Code";
//             ShipStcd := StateRec3."State Code (GST Reg. No.)";
//             //ShipStcd := StateRec2."State Code (GST Reg. No.)"; // DJ 11102020
//           END
//           ELSE IF SalesCrMemoHeader."GST Customer Type" = SalesCrMemoHeader."GST Customer Type"::Export THEN BEGIN
//             Catg := 'EXPWOP';
//             RegRev := 'N';
//             BuyerGstin := 'URP';
//             BuyerPos := '96';
//             BuyerStcd := '96';
//             BuyerPincode := '999999';
//             ShipGSTIN := 'URP';
//             ShipPincode := '999999';
//             ShipStcd := '96';
//            END
//           ELSE IF SalesCrMemoHeader."GST Customer Type" = SalesCrMemoHeader."GST Customer Type"::"Deemed Export" THEN BEGIN
//             Catg := 'DEXP';
//             RegRev := 'N';
//             BuyerGstin := 'URP';
//             BuyerPos := '96';
//             BuyerStcd := '96';
//             BuyerPincode := '999999';
//             ShipGSTIN := 'URP';
//             ShipPincode := '999999';
//             ShipStcd := '96';
//           END
//           ELSE IF (SalesCrMemoHeader."GST Customer Type" = SalesCrMemoHeader."GST Customer Type"::"SEZ Development") OR (SalesCrMemoHeader."GST Customer Type" = SalesCrMemoHeader."GST Customer Type"::"SEZ Unit") THEN BEGIN
//             Catg := 'SEZWOP';
//             RegRev := 'N';
//             IF StateRec2.GET(CustomerRec."State Code") THEN;// DJ 16102020
//             BuyerGstin := CustomerRec."GST Registration No.";
//             BuyerPos := StateRec2."State Code (GST Reg. No.)";
//             BuyerStcd := StateRec2."State Code (GST Reg. No.)";
//             BuyerPincode := CustomerRec."Post Code";
//             ShipPincode := SalesCrMemoHeader."Ship-to Post Code";
//             //ShipStcd := StateRec3."State Code (GST Reg. No.)";
//             ShipStcd := StateRec2."State Code (GST Reg. No.)"; // DJ 11102020
//           END;

//         END;
//         TaxSchema := '{'
//         +'  "Version": "1.1",' ;

//         Trsnsdtls := '  "TranDtls": {'
//         +'    "TaxSch": "GST",'
//         +'    "SupTyp": "' + Catg + '"'
//         //+'    "RegRev": "'+ RegRev +'",'
//         //+'    "Typ": "REG",   '
//         //+'    "EcmTrn": "N",'
//         //+'    "EcmGstin": null,'
//         //+'    "IgstOnIntra": "N"'
//         +' },' ;

//         DocDtls := '  "DocDtls": {'
//         +'    "Typ": "'+DocType+'",'
//         +'    "No": "' + txtDocNo + '",'
//         +'    "Dt": "'+ DocDate +'"'
//         +'  },';

//         SellerDtls := '  "SellerDtls": {'
//         +'    "Gstin": "'+LocRec."GST Registration No."+'",'
//         //+'    "LglNm": "'+ LocRec.Name +'",'     //AR05NOV20
//         +'    "LglNm": "'+ CompanyInfo.Name +'",'  //AR05NOV20
//         //+'    "TrdNm": "'+ LocRec.Name +'",'     //AR05NOV20
//         +'    "TrdNm": "'+ CompanyInfo.Name +'",'  //AR05NOV20
//         +'    "Addr1": "'+LocRec.Address+'"';
//         IF LocRec."Address 2" <> '' THEN
//           SellerDtls := SellerDtls + ',' +'    "Addr2": "'+LocRec."Address 2"+'"'
//         ELSE
//           SellerDtls := SellerDtls;
//         SellerDtls := SellerDtls+ ',' +'    "Loc": "'+LocRec.City+'"';

//         IF (LocRec."Post Code" <> '') THEN BEGIN
//           SellerDtls :=SellerDtls + ',' +'    "Pin": '+LocRec."Post Code"+'';
//         END ELSE
//           SellerDtls :=SellerDtls;
//         IF StateRec."State Code (GST Reg. No.)" <> '' THEN BEGIN
//           SellerDtls :=SellerDtls + ',' +'    "Stcd": "'+StateRec."State Code (GST Reg. No.)"+'"';
//         END ELSE
//           SellerDtls :=SellerDtls;

//         IF LocRec."Phone No." <> '' THEN BEGIN
//           SellerPhoneNo := '"Ph": "'+LocRec."Phone No."+'"';
//           SellerDtls :=SellerDtls + ',' + SellerPhoneNo;
//         END ELSE
//           SellerDtls :=SellerDtls;

//         IF LocRec."E-Mail" <> '' THEN BEGIN
//           SellerEmail := 'Em": "'+LocRec."E-Mail"+'"';
//           SellerDtls :=SellerDtls + ',"'+SellerEmail;
//         END ELSE
//           SellerDtls := SellerDtls;
//         SellerDtls := SellerDtls +'  },';

//         BuyerDtls := '  "BuyerDtls": {'
//         +'    "Gstin": "'+ BuyerGstin +'",'
//         +'    "LglNm": "'+ CustomerRec2.Name +'",'
//         +'    "TrdNm": "'+ CustomerRec2.Name +'",'
//         +'    "Pos": "'+ BuyerPos +'",'
//         /*
//         +'    "Gstin": "'+ CustomerRec."GST Registration No." +'",'
//         +'    "LglNm": "'+ CustomerRec.Name +'",'
//         +'    "TrdNm": "'+ CustomerRec.Name +'",'
//         +'    "Pos": "'+ StateRec2."State Code (GST Reg. No.)" +'",'
//         */
//         +'    "Addr1": "'+ CustomerRec2.Address +'"';

//         IF CustomerRec."Address 2" <> '' THEN BEGIN
//           BuyerDtls :=BuyerDtls + ',' +'    "Addr2": "'+ CustomerRec2."Address 2" +'"';
//         END ELSE
//           BuyerDtls :=BuyerDtls;

//         BuyerDtls :=BuyerDtls + ',' +'    "Loc": "'+LocRec.City+'"';

//         IF (BuyerPincode <> '') AND (BuyerPincode <> '0') THEN BEGIN
//           BuyerDtls :=BuyerDtls + ',' +'    "Pin": '+ BuyerPincode +'';
//         END ELSE
//           BuyerDtls :=BuyerDtls;

//         IF BuyerStcd <> '' THEN BEGIN
//           BuyerDtls :=BuyerDtls + ',' +'    "Stcd": "'+ BuyerStcd +'"';
//         END ELSE
//           BuyerDtls :=BuyerDtls;

//         IF CustomerRec2."Phone No." <> '' THEN BEGIN
//           BuyerPhoneNo := '"Ph": "'+CustomerRec2."Phone No."+'"';
//           BuyerDtls :=BuyerDtls + ',' + BuyerPhoneNo;
//         END ELSE
//           BuyerDtls :=BuyerDtls;

//         IF CustomerRec2."E-Mail" <> '' THEN BEGIN
//           BuyerEmail := 'Em": "'+CustomerRec2."E-Mail"+'"';
//           BuyerDtls :=BuyerDtls + ',"'+BuyerEmail;
//         END ELSE
//           BuyerDtls:= BuyerDtls;
//         BuyerDtls:= BuyerDtls+'  },';

//         DispDtls := '  "DispDtls": {'
//         +'    "Nm": "'+ LocRec.Name +'",'
//         +'    "Addr1": "'+LocRec.Address+'"';
//         IF LocRec."Address 2" <> '' THEN
//           DispDtls := DispDtls + ',' +'    "Addr2": "'+LocRec."Address 2"+'"'
//         ELSE
//           DispDtls := DispDtls;
//         DispDtls := DispDtls + ',' +'    "Loc": "'+LocRec.City+'",'
//         +'    "Pin": '+LocRec."Post Code"+' ,'
//         +'    "Stcd": "'+StateRec."State Code (GST Reg. No.)"+'"'
//         +'  },';

//         IF IsInvoice THEN BEGIN
//           ShipDtls :=  '"ShipDtls": {'
//           +'    "Gstin": "'+ShipGSTIN+'",'
//           +'    "LglNm": "'+ SalesInvoiceHeader."Ship-to Name" +'",'
//           +'    "TrdNm": "'+ SalesInvoiceHeader."Ship-to Name" +'",'
//           +'    "Addr1": "'+ SalesInvoiceHeader."Ship-to Address" +'"';
//           IF SalesInvoiceHeader."Ship-to Address 2" <> '' THEN
//             ShipDtls := ShipDtls + ',' +'    "Addr2": "'+ SalesInvoiceHeader."Ship-to Address 2" +'"'
//           ELSE
//             ShipDtls := ShipDtls;
//         ShipDtls := ShipDtls + ',' +'    "Loc": "'+SalesInvoiceHeader."Ship-to City"+'"';

//         IF (ShipPincode <> '') THEN BEGIN
//           ShipDtls := ShipDtls + ',' +'    "Pin": '+ ShipPincode +'';
//         END ELSE
//           ShipDtls := ShipDtls;

//         IF ShipStcd <> '' THEN BEGIN
//           ShipDtls := ShipDtls + ',' +'    "Stcd": "'+ ShipStcd +'"';
//         END ELSE
//           ShipDtls := ShipDtls;
//         ShipDtls := ShipDtls  +'  },';
//         END ELSE BEGIN

//         //AR 23Nov20
//          ShipDtls :=  '"ShipDtls": {'

//          //IF LocRec.GET(SalesCrMemoHeader."Location Code") THEN;
//          // IF StateRec.GET(LocRec."State Code") THEN;

//           //+'    "Gstin": "'+ShipGSTIN+'",'
//             +'    "Gstin": "'+LocRec."GST Registration No."+'",'
//           //+'    "LglNm": "'+ SalesCrMemoHeader."Ship-to Name" +'",'
//             +'    "LglNm": "'+ CompanyInfo.Name +'",'  //AR05NOV20
//           //+'    "TrdNm": "'+ SalesCrMemoHeader."Ship-to Name" +'",'
//             +'    "TrdNm": "'+ CompanyInfo.Name +'",'  //AR05NOV20

//           +'    "Addr1": "'+ LocRec.Address +'"';
//           IF LocRec."Address 2" <> '' THEN
//             ShipDtls := ShipDtls + ',' +'     "Addr2": "'+LocRec."Address 2"+'"'
//           ELSE
//             ShipDtls := ShipDtls;
//           ShipDtls := ShipDtls + ',' +'     "Loc": "'+LocRec.City+'"';

//         IF (LocRec."Post Code" <> '') THEN BEGIN
//           ShipDtls := ShipDtls + ',' +'    "Pin": '+ LocRec."Post Code"+'';
//         END ELSE
//           ShipDtls := ShipDtls;

//         IF StateRec."State Code (GST Reg. No.)" <> '' THEN BEGIN
//           ShipDtls := ShipDtls + ',' +'    "Stcd": "'+ StateRec."State Code (GST Reg. No.)"+'"';
//         END ELSE
//           ShipDtls := ShipDtls;
//         ShipDtls := ShipDtls  +'  },';

//         END;
//         //AR 23Nov20

//         //AR 23Nov20 commented prev code
//         /*
//           ShipDtls :=  '"ShipDtls": {'
//           +'    "Gstin": "'+ShipGSTIN+'",'
//           +'    "LglNm": "'+ SalesCrMemoHeader."Ship-to Name" +'",'
//           +'    "TrdNm": "'+ SalesCrMemoHeader."Ship-to Name" +'",'
//           +'    "Addr1": "'+ SalesCrMemoHeader."Ship-to Address" +'"';
//           IF SalesCrMemoHeader."Ship-to Address 2" <> '' THEN
//             ShipDtls := ShipDtls + ',' +'    "Addr2": "'+ SalesCrMemoHeader."Ship-to Address 2" +'"'
//           ELSE
//             ShipDtls := ShipDtls;
//           ShipDtls := ShipDtls + ',' +'    "Loc": "'+SalesCrMemoHeader."Ship-to City"+'"';

//         IF (ShipPincode <> '') THEN BEGIN
//           ShipDtls := ShipDtls + ',' +'    "Pin": '+ ShipPincode +'';
//         END ELSE
//           ShipDtls := ShipDtls;

//         IF ShipStcd <> '' THEN BEGIN
//           ShipDtls := ShipDtls + ',' +'    "Stcd": "'+ ShipStcd +'"';
//         END ELSE
//           ShipDtls := ShipDtls;
//         ShipDtls := ShipDtls  +'  },';

//         END;
//         */

//         ItemListDtls := ItemListDtls +'"ItemList": [';

//         IF IsInvoice THEN BEGIN
//           SalesInvoiceLine.SETRANGE("Document No.",txtDocNo);
//           SalesInvoiceLine.SETFILTER("No.",'<>%1','');
//           SalesInvoiceLine.SETFILTER(Quantity,'<>%1',0);
//           SalesInvoiceLine.SETFILTER(Amount,'>%1',1);
//             IF SalesInvoiceLine.FINDSET THEN BEGIN
//               IF (SalesInvoiceLine.COUNT > 100) THEN
//                 ERROR(SalesLinesErr,SalesInvoiceLine.COUNT);
//               REPEAT
//                 BchDtls := '';
//                 SNo += 1;

//                 AssAmt := ROUND(
//                   CurrExchRate.ExchangeAmtFCYToLCY(
//                     WORKDATE,SalesInvoiceHeader."Currency Code",SalesInvoiceLine."GST Base Amount",SalesInvoiceHeader."Currency Factor"),0.01,'=');
//                 TotAmt := ROUND(
//                   CurrExchRate.ExchangeAmtFCYToLCY(
//                     WORKDATE,SalesInvoiceHeader."Currency Code",SalesInvoiceLine."Line Amount",SalesInvoiceHeader."Currency Factor"),0.01,'=');
//                 TotalItemVal := ROUND(
//                   CurrExchRate.ExchangeAmtFCYToLCY(
//                     WORKDATE,SalesInvoiceHeader."Currency Code",(SalesInvoiceLine."Amount To Customer"),SalesInvoiceHeader."Currency Factor"),0.01,'=');
//                 DiscAmount := ROUND(
//                   CurrExchRate.ExchangeAmtFCYToLCY(
//                     WORKDATE,SalesInvoiceHeader."Currency Code",(SalesInvoiceLine."Line Discount Amount"),SalesInvoiceHeader."Currency Factor"),0.01,'=');
//                 TDSTCSAmount := ROUND(
//                   CurrExchRate.ExchangeAmtFCYToLCY(
//                     WORKDATE,SalesInvoiceHeader."Currency Code",(SalesInvoiceLine."TDS/TCS Amount"),SalesInvoiceHeader."Currency Factor"),0.01,'=');

//                 IF SalesInvoiceLine."Free Supply" THEN
//                   FreeQty := SalesInvoiceLine.Quantity
//                 ELSE
//                   FreeQty := 0;
//                 GetGSTCompRate(SalesInvoiceLine."Document No.",SalesInvoiceLine."Line No.",
//                   CgstRt,SgstRt,IgstRt,CesRt,CesNonAdval,StateCes);

//                 IF HSNRec.GET(SalesInvoiceLine."GST Group Code",SalesInvoiceLine."HSN/SAC Code") THEN BEGIN
//                   IF HSNRec.Type = HSNRec.Type::HSN THEN
//                     ISServc := 'N'
//                   ELSE
//                     ISServc := 'Y'
//                 END;

//                 GstSetup.RESET;
//                 GstSetup.SETRANGE("GST Group Code",SalesInvoiceLine."GST Group Code");
//                 GstSetup.SETRANGE("GST Jurisdiction Type",GstSetup."GST Jurisdiction Type"::Interstate);
//                 IF GstSetup.FINDFIRST THEN
//                   GSTRate := GstSetup."GST Component %";

//                 //RSPl AviMali 05022021 <<
//                   IF SalesInvoiceLine."GST %" = 0 THEN
//                     GSTRate := 0;
//                 //RSPl AviMali 05022021 >>

//                 ItemListDtls += '{'
//                 +'      "SlNo": "'+FORMAT(SNo)+'",'
//                 +'      "IsServc": "'+ISServc+'",'
//                 +'      "PrdDesc": "'+SalesInvoiceLine.Description+'",'
//                 +'      "HsnCd": "'+SalesInvoiceLine."HSN/SAC Code"+'",';

//                 InvoiceRowID := ItemTrackingManagement.ComposeRowID(DATABASE::"Sales Invoice Line",0,txtDocNo,'',0,SalesInvoiceLine."Line No.");
//                 ValueEntryRelation.SETCURRENTKEY("Source RowId");
//                 ValueEntryRelation.SETRANGE("Source RowId",InvoiceRowID);
//                 IF ValueEntryRelation.FINDSET THEN BEGIN
//                   REPEAT
//                     ValueEntry.GET(ValueEntryRelation."Value Entry No.");
//                     ItemLedgerEntry.GET(ValueEntry."Item Ledger Entry No.");
//                     //RSPLSUM 13Jan21>>
//                     BatchDetailsName := COPYSTR(ItemLedgerEntry."Lot No." + ItemLedgerEntry."Serial No.",1,20);
//                     IF STRLEN(BatchDetailsName) = 1 THEN
//                       BatchDetailsName := '00' + BatchDetailsName
//                     ELSE IF STRLEN(BatchDetailsName) = 2 THEN
//                       BatchDetailsName := '0' + BatchDetailsName;

//                       BchDtls +=' "BchDtls": {'
//                        +'      "Nm": "'+BatchDetailsName+'"'
//                        +'  },';

//                     //RSPLSUM 13Jan21<<

//                       //RSPLSUM 13Jan21 Comment begin>>
//                       /*
//                       BchDtls +=' "BchDtls": {'
//                        +'      "Nm": "'+COPYSTR(ItemLedgerEntry."Lot No." + ItemLedgerEntry."Serial No.",1,20)+'"'
//                        //+'      "ExpDt": "'+FORMAT(TODAY,0,'<Day,2>/<Month,2>/<Year4>')+'",'
//                        //+'      "WrDt": "'+FORMAT(TODAY,0,'<Day,2>/<Month,2>/<Year4>')+'"'
//                        // +'      "ExpDt": "'+FORMAT(ItemLedgerEntry."Expiration Date",0,'<Day,2>/<Month,2>/<Year4>')+'",'
//                        // +'      "WrDt": "'+FORMAT(ItemLedgerEntry."Warranty Date",0,'<Day,2>/<Month,2>/<Year4>')+'"'
//                        +'  },';
//                       */
//                       //RSPLSUM 13Jan21 Comment end<<
//                   UNTIL ValueEntryRelation.NEXT = 0;
//                 END;
//                 IF ItemRec.GET(SalesInvoiceLine."No.") THEN;
//                 IF recUnitofMeasure.GET(SalesInvoiceLine."Unit of Measure Code")  THEN
//                   qtyUnit := recUnitofMeasure."GST Reporting UQC";
//                 IF (SalesInvoiceLine.Type = SalesInvoiceLine.Type::"G/L Account") AND (SalesInvoiceLine."Unit of Measure Code"= '') THEN
//                   qtyUnit := 'NOS';
//                 GetGSTVal(AssVal,CgstVal,SgstVal,IgstVal,CesVal,StCesVal,CesNonAdval,Disc,OthChrg,TotInvVal,txtDocNo,SalesInvoiceLine."Line No.");
//                 ItemListDtls := ItemListDtls + BchDtls;
//                 ItemListDtls += '"Qty": '+DELCHR(FORMAT(SalesInvoiceLine.Quantity), '=',',')+','
//                 +'      "Unit": "'+qtyUnit+'",'
//                 +'      "UnitPrice": '+DELCHR(FORMAT(ROUND((SalesInvoiceLine."Unit Price"),0.01,'=')), '=',',')+','
//                 +'      "TotAmt": '+DELCHR(FORMAT(ROUND((TotAmt+OthChrg+DiscAmount),0.01,'=')), '=',',')+','
//                 +'      "Discount":'+DELCHR(FORMAT(DiscAmount), '=',',')+','
//                 +'      "AssAmt":'+DELCHR(FORMAT(AssAmt), '=',',')+','
//                 +'      "GstRt": '+DELCHR(FORMAT(GSTRate), '=',',')+','
//                 +'      "SgstAmt": '+DELCHR(FORMAT(SgstVal), '=',',')+','
//                 +'      "IgstAmt": '+DELCHR(FORMAT(IgstVal), '=',',')+','
//                 +'      "CgstAmt": '+DELCHR(FORMAT(CgstVal), '=',',')+','
//                 +'      "CesRt": '+DELCHR(FORMAT(CesRt), '=',',')+','
//                 +'      "CesAmt": '+DELCHR(FORMAT(CesVal), '=',',')+','
//                 +'      "CesNonAdvlAmt": '+DELCHR(FORMAT(CesNonAdval), '=',',')+','
//                 +'      "StateCesRt": '+DELCHR(FORMAT(StateCes), '=',',')+','
//                 +'      "StateCesAmt": '+DELCHR(FORMAT(StCesVal), '=',',')+','
//                 +'      "StateCesNonAdvlAmt": '+DELCHR(FORMAT(0), '=',',')+','
//                 +'      "OthChrg": '+DELCHR(FORMAT(TDSTCSAmount), '=',',')+','
//                 +'      "TotItemVal": '+DELCHR(FORMAT(TotalItemVal), '=',',')+''
//                 +'    },' ;
//                 TotalSGSTAmt +=SgstVal;
//                 TotalIGSTAmt +=IgstVal;
//                 TotalCGSTAmt +=CgstVal;
//                 CesVal +=CesNonAdval;
//               UNTIL SalesInvoiceLine.NEXT = 0;
//               ItemListDtls  :=  COPYSTR(ItemListDtls, 1,  STRLEN(ItemListDtls)-1);
//               ItemListDtls +=  '],';
//             END;
//         END ELSE BEGIN
//           SalesCrMemoLine.SETRANGE("Document No.",txtDocNo);
//           SalesCrMemoLine.SETFILTER("No.",'<>%1','');
//           SalesCrMemoLine.SETFILTER(Quantity,'<>%1',0);
//           SalesCrMemoLine.SETFILTER(Amount,'>%1',1);
//           IF SalesCrMemoLine.FIND('-') THEN BEGIN
//             IF SalesCrMemoLine.COUNT > 100 THEN
//               ERROR(SalesLinesErr,SalesCrMemoLine.COUNT);
//             REPEAT
//             BchDtls := '';
//             SNo += 1;

//             AssAmt := ROUND(
//               CurrExchRate.ExchangeAmtFCYToLCY(
//                 WORKDATE,SalesCrMemoHeader."Currency Code",SalesCrMemoLine."GST Base Amount",SalesCrMemoHeader."Currency Factor"),0.01,'=');
//             TotAmt := ROUND(
//               CurrExchRate.ExchangeAmtFCYToLCY(
//                 WORKDATE,SalesCrMemoHeader."Currency Code",SalesCrMemoLine."Line Amount",SalesCrMemoHeader."Currency Factor"),0.01,'=');
//             TotalItemVal := ROUND(
//               CurrExchRate.ExchangeAmtFCYToLCY(
//                 WORKDATE,SalesCrMemoHeader."Currency Code",(SalesCrMemoLine."Amount To Customer"),SalesCrMemoHeader."Currency Factor"),0.01,'=');
//             DiscAmount := ROUND(
//               CurrExchRate.ExchangeAmtFCYToLCY(
//                 WORKDATE,SalesCrMemoHeader."Currency Code",(SalesCrMemoLine."Line Discount Amount"),SalesCrMemoHeader."Currency Factor"),0.01,'=');
//              TDSTCSAmount := ROUND(
//                CurrExchRate.ExchangeAmtFCYToLCY(
//                  WORKDATE,SalesCrMemoHeader."Currency Code",(SalesCrMemoLine."TDS/TCS Amount"),SalesCrMemoHeader."Currency Factor"),0.01,'=');

//               IF SalesCrMemoLine."Free Supply" THEN
//                 FreeQty := SalesCrMemoLine.Quantity
//               ELSE
//                 FreeQty := 0;
//               GetGSTCompRate(SalesCrMemoLine."Document No.",SalesCrMemoLine."Line No.",
//                 CgstRt,SgstRt,IgstRt,CesRt,CesNonAdval,StateCes);

//                 IF HSNRec.GET(SalesCrMemoLine."GST Group Code",SalesCrMemoLine."HSN/SAC Code") THEN BEGIN
//                   IF HSNRec.Type = HSNRec.Type::HSN THEN
//                     ISServc := 'N'
//                   ELSE
//                     ISServc := 'Y'
//                 END;

//               GstSetup.RESET;
//               GstSetup.SETRANGE("GST Group Code",SalesCrMemoLine."GST Group Code");
//               GstSetup.SETRANGE("GST Jurisdiction Type",GstSetup."GST Jurisdiction Type"::Interstate);
//               IF GstSetup.FINDFIRST THEN
//                 GSTRate := GstSetup."GST Component %";

//                //RSPl AviMali 05022021  <<
//                   IF SalesCrMemoLine."GST %" =0 THEN
//                     GSTRate:=0;
//                //RSPl AviMali 05022021  >>

//               ItemListDtls += '{'
//               +'      "SlNo": "'+FORMAT(SNo)+'",'
//               +'      "IsServc": "'+ISServc+'",'
//               +'      "PrdDesc": "'+SalesCrMemoLine.Description+'",'
//               +'      "HsnCd": "'+SalesCrMemoLine."HSN/SAC Code"+'",';
//               InvoiceRowID := ItemTrackingManagement.ComposeRowID(DATABASE::"Sales Cr.Memo Line",0,txtDocNo,'',0,SalesCrMemoLine."Line No.");
//               ValueEntryRelation.SETCURRENTKEY("Source RowId");
//               ValueEntryRelation.SETRANGE("Source RowId",InvoiceRowID);
//               IF ValueEntryRelation.FINDSET THEN BEGIN
//                 REPEAT
//                   ValueEntry.GET(ValueEntryRelation."Value Entry No.");
//                   ItemLedgerEntry.GET(ValueEntry."Item Ledger Entry No.");
//                     BchDtls +=' "BchDtls": {'
//                      +'      "Nm": "'+COPYSTR(ItemLedgerEntry."Lot No." + ItemLedgerEntry."Serial No.",1,20)+'"'
//                      //+'      "ExpDt": "'+FORMAT(TODAY,0,'<Day,2>/<Month,2>/<Year4>')+'",'
//                      //+'      "WrDt": "'+FORMAT(TODAY,0,'<Day,2>/<Month,2>/<Year4>')+'"'
//                      // +'      "ExpDt": "'+FORMAT(ItemLedgerEntry."Expiration Date",0,'<Day,2>/<Month,2>/<Year4>')+'",'
//                       //+'      "WrDt": "'+FORMAT(ItemLedgerEntry."Warranty Date",0,'<Day,2>/<Month,2>/<Year4>')+'"'
//                      +'  },';
//                 UNTIL ValueEntryRelation.NEXT = 0;
//               END;
//                 IF ItemRec.GET(SalesCrMemoLine."No.") THEN;
//                 IF recUnitofMeasure.GET(SalesCrMemoLine."Unit of Measure Code")  THEN
//                   qtyUnit := recUnitofMeasure."GST Reporting UQC";
//                 IF (SalesCrMemoLine.Type = SalesCrMemoLine.Type::"G/L Account") AND (SalesCrMemoLine."Unit of Measure Code"= '') THEN
//                   qtyUnit := 'NOS';
//                 GetGSTVal(AssVal,CgstVal,SgstVal,IgstVal,CesVal,StCesVal,CesNonAdval,Disc,OthChrg,TotInvVal,txtDocNo,SalesCrMemoLine."Line No.");
//                 ItemListDtls := ItemListDtls + BchDtls;
//                 ItemListDtls += '"Qty": '+DELCHR(FORMAT(SalesCrMemoLine.Quantity), '=',',')+','
//                 +'      "Unit": "'+qtyUnit+'",'
//                 +'      "UnitPrice": '+DELCHR(FORMAT(ROUND((SalesCrMemoLine."Unit Price"),0.01,'=')), '=',',')+','
//                 +'      "TotAmt": '+DELCHR(FORMAT(ROUND((TotAmt+OthChrg+DiscAmount),0.01,'=')), '=',',')+','
//                 +'      "Discount":'+DELCHR(FORMAT(DiscAmount), '=',',')+','
//                 +'      "AssAmt":'+DELCHR(FORMAT(AssAmt), '=',',')+','
//                 +'      "GstRt": '+DELCHR(FORMAT(GSTRate), '=',',')+','
//                 +'      "SgstAmt": '+DELCHR(FORMAT(SgstVal), '=',',')+','
//                 +'      "IgstAmt": '+DELCHR(FORMAT(IgstVal), '=',',')+','
//                 +'      "CgstAmt": '+DELCHR(FORMAT(CgstVal), '=',',')+','
//                 +'      "CesRt": '+DELCHR(FORMAT(CesRt), '=',',')+','
//                 +'      "CesAmt": '+DELCHR(FORMAT(CesVal), '=',',')+','
//                 +'      "CesNonAdvlAmt": '+DELCHR(FORMAT(CesNonAdval), '=',',')+','
//                 +'      "StateCesRt": '+DELCHR(FORMAT(StateCes), '=',',')+','
//                 +'      "StateCesAmt": '+DELCHR(FORMAT(StCesVal), '=',',')+','
//                 +'      "StateCesNonAdvlAmt": '+DELCHR(FORMAT(0), '=',',')+','
//                 +'      "OthChrg": '+DELCHR(FORMAT(TDSTCSAmount), '=',',')+','
//                 //+'      "OthChrg": '+DELCHR(FORMAT(-OthChrg), '=',',')+','//RSPLSID Temp Comment //Vijay
//                 //+'      "OthChrg": '+DELCHR(FORMAT(OthChrg), '=',',')+','//RSPLSID Temp Code
//                 //+'      "TotItemVal": '+DELCHR(FORMAT(TotalItemVal-OthChrg), '=',',')+''
//                 //+'      "OthChrg": '+DELCHR(FORMAT(TDSTCSAmount+ABS(OthChrg)), '=',',')+',' //rspldp310723
//                 +'      "TotItemVal": '+DELCHR(FORMAT(TotalItemVal), '=',',')+''
//                 +'    },' ;
//                 TotalSGSTAmt +=SgstVal;
//                 TotalIGSTAmt +=IgstVal;
//                 TotalCGSTAmt +=CgstVal;
//                 CesVal +=CesNonAdval;
//               UNTIL SalesCrMemoLine.NEXT = 0;
//               ItemListDtls  :=  COPYSTR(ItemListDtls, 1,  STRLEN(ItemListDtls)-1);
//               ItemListDtls +=  '],';
//             END;
//          END;

//          ValDtls := '"ValDtls": {'
//          +'    "AssVal": '+DELCHR(FORMAT(AssVal), '=',',')+','
//          +'    "SgstVal": '+DELCHR(FORMAT(TotalSGSTAmt), '=',',')+','
//          +'    "CgstVal": '+DELCHR(FORMAT(TotalCGSTAmt), '=',',')+','
//          +'    "IgstVal": '+DELCHR(FORMAT(TotalIGSTAmt), '=',',')+','
//          +'    "CesVal": '+DELCHR(FORMAT(CesVal), '=',',')+','
//          +'    "StCesVal": '+DELCHR(FORMAT(StCesVal), '=',',')+','
//          +'    "RndOffAmt": null,'
//          +'    "TotInvVal": '+DELCHR(FORMAT(TotInvVal), '=',',')+''
//          +'}';

//         /*
//         PayDtls := ',"PayDtls": {'
//         +'    "Nm": "'+CustomerRec2.Name+'",'
//         //+'    "AccDet": "'+BankAccount."Bank Account No."+'",'
//         +'    "AccDet": "'+AccDet+'",'
//         +'    "Mode": "'+SalesInvoiceHeader."Payment Method Code"+'",'
//         //+'    "FinInsbr": "'+SalesInvoiceHeader."Bank Account"+'",'
//         +'    "FinInsbr": "'+FinInsbr+'",'
//         +'    "PayTerm": "'+SalesInvoiceHeader."Payment Terms Code"+'",'
//         +'    "PayInstr": "'+PayInstr+'",'
//         +'    "CrTrn": "'+CrTrn+'",'
//         +'    "DirDr": "'+DirDr+'",'
//         +'    "CrDay": '+CrDay+','
//         +'    "PaidAmt": '+PaidAmt+','
//         +'    "PaymtDue": '+DELCHR(FORMAT(PaymentDue), '=',',')+''
//         +'    },';


//         RefDtls := '"RefDtls": {'
//         +'  "InvRm": null,'
//         +'    "DocPerdDtls": {'
//         //+'  "InvStDt": "'+InvStDt+'",'
//         //+'  "InvEndDt": "'+InvEndDt+'"'
//         +'  "InvStDt": "'+FORMAT(TODAY,0,'<Day,2>/<Month,2>/<Year4>')+'",'
//         +'  "InvEndDt": "'+FORMAT(TODAY,0,'<Day,2>/<Month,2>/<Year4>')+'"'

//         +'    },'
//         +'    "PrecDocDtls": ['
//         +'      {'
//               +'  "InvNo": "'+InvNo+'",'
//               //+'  "InvDt": "'+InvDt+'",'
//               +'  "InvDt": "'+FORMAT(TODAY,0,'<Day,2>/<Month,2>/<Year4>')+'",'
//               +'  "OthRefNo": "'+OthRefNo+'"'
//         +'      }'
//         +'    ],'
//         +'    "ContrDtls": ['
//         +'      {'
//                 +'  "RecAdvRefr": "'+RecAdvRefr+'",'
//                // +'  "RecAdvDt": "'+RecAdvDt+'",'
//                 +'  "RecAdvDt": "'+FORMAT(TODAY,0,'<Day,2>/<Month,2>/<Year4>')+'",'
//                 +'  "TendRefr": "'+TendRefr+'",'
//                 +'  "ContrRefr": "'+ContrRefr+'",'
//                 +'  "ExtRefr": "'+ExtRefr+'",'
//                 +'  "ProjRefr": "'+ProjRefr+'",'
//                 +'  "PORefr": "'+SalesCrMemoHeader."External Document No."+'",'
//                // +'  "PORefDt": "'+PORefDt+'"'
//                +'  "PORefDt": "'+FORMAT(TODAY,0,'<Day,2>/<Month,2>/<Year4>')+'"'
//         +'      }'
//         +'    ]'
//         +'  },';

//         AddlDocDtls := '"AddlDocDtls": ['
//         +'   {'
//         +'     "Url": "'+Url+'",'
//         +'     "Docs": "'+Docs+'",'
//         +'     "Info": "'+Info+'"'
//         +'   }'
//         +' ]';
//         */
//         IF IsInvoice THEN BEGIN
//           IF SalesInvoiceHeader."GST Customer Type" = SalesInvoiceHeader."GST Customer Type"::Export THEN BEGIN
//             ExpDtls := ',"ExpDtls": {'
//             +'  "ShipBNo": "'+SalesInvoiceHeader."Bill Of Export No."+'",'
//             +'  "ShipBDt": "'+FORMAT(SalesInvoiceHeader."Bill Of Export Date",0,'<Day,2>/<Month,2>/<Year4>')+'"';
//             //+'  "Port": '+SalesInvoiceHeader."Exit Point"+','
//             //+'  "RefClm": "'+SalesInvoiceHeader."LR/RR No."+'",'
//             IF SalesInvoiceHeader."Currency Code" <> '' THEN
//               ExpDtls := ExpDtls + ',' +'   "ForCur": "'+SalesInvoiceHeader."Currency Code"+'"'
//             ELSE
//               ExpDtls := ExpDtls;
//             ExpDtls := ExpDtls +',' +'  "CntCode": "'+SalesInvoiceHeader."Sell-to Country/Region Code"+'",'
//             +'  "ExpDuty": '+'null'+''
//             +'  }';
//            END;
//         END ELSE BEGIN
//           IF SalesCrMemoHeader."GST Customer Type" = SalesCrMemoHeader."GST Customer Type"::Export THEN BEGIN
//             ExpDtls := ',"ExpDtls": {'
//             +'  "ShipBNo": "'+SalesCrMemoHeader."Bill Of Export No."+'",'
//             +'  "ShipBDt": "'+FORMAT(SalesCrMemoHeader."Bill Of Export Date",0,'<Day,2>/<Month,2>/<Year4>')+'"';
//            // +'  "Port": '+SalesCrMemoHeader."Exit Point"+','
//         //  +'  "RefClm": "'+SalesCrMemoHeader."LR/RR No."+'",'
//             IF SalesCrMemoHeader."Currency Code" <> '' THEN
//               ExpDtls := ExpDtls + ',' +'   "ForCur": "'+SalesCrMemoHeader."Currency Code"+'"'
//             ELSE
//               ExpDtls := ExpDtls;
//             ExpDtls := ExpDtls +',' +'  "CntCode": "'+SalesCrMemoHeader."Sell-to Country/Region Code"+'",'
//             +'  "ExpDuty": '+'null'+''
//             +'  }';
//            END;
//         END;

//         //ExpDtls :='"ExpDtls": null,

//         // IF AddEwbDtls THEN BEGIN
//         //  Ewbdtls :=  ',"EwbDtls": {'
//         //  +'  "Transid": "'+TranporterRec."GSTIN No."+'",'
//         //  +'  "Transname": "'+TranporterRec.Name+'",'
//         //  +'  "Distance": '+DELCHR(FORMAT(SalesInvoiceHeader."Distance in kms"), '=',',')+','
//         //  +'  "Transdocno": "'+SalesInvoiceHeader."LR/RR No."+'",'
//         //  +'  "TransdocDt": "'+FORMAT(SalesInvoiceHeader."LR/RR Date",0,'<Day,2>/<Month,2>/<Year4>')+'",'
//         //  +'  "Vehno": "'+SalesInvoiceHeader."Vehicle No."+'",'
//         //  +'  "Vehtype": "'+'R'+'",'
//         //  +'  "TransMode": "'+ShipMethodRec."Transport Mode (EWB)"+'"'
//         //  +'  }'
//         //  +'  }';
//         // END ELSE BEGIN
//         Ewbdtls := '}';
//         // END;
//         // }
//         IRNJson := TaxSchema + Trsnsdtls + DocDtls + SellerDtls + BuyerDtls +DispDtls + ShipDtls + ItemListDtls + ValDtls + PayDtls + RefDtls + AddlDocDtls + ExpDtls + Ewbdtls;

//     end;

//     [Scope('Internal')]
//     procedure InitializeVariables()
//     begin
//         AccDet := 'null';
//         FinInsbr := 'null';
//         PayInstr := 'null';
//         CrTrn := 'null';
//         DirDr := 'null';
//         CrDay := 'null';
//         PaidAmt := 'null';
//         PaymtDue := 'null';
//         InvRm := 'null';
//         InvStDt := 'null';
//         InvEndDt := 'null';
//         InvNo := 'null';
//         InvDt := 'null';
//         OthRefNo := 'null';
//         RecAdvRefr := 'null';
//         RecAdvDt := 'null';
//         TendRefr := 'null';
//         ContrRefr := 'null';
//         ExtRefr := 'null';
//         ProjRefr := 'null';
//         PORefr := 'null';
//         PORefDt := 'null';
//         Url := 'null';
//         Docs := 'null';
//         Info := 'null';
//     end;

//     [Scope('Internal')]
//     procedure SetSalesInvHeader(DocumentNo: Code[20])
//     begin
//         IF SalesInvoiceHeader.GET(DocumentNo) THEN
//         IsInvoice := TRUE;
//     end;

//     [Scope('Internal')]
//     procedure SetCrMemoHeader(DocumentNo: Code[20])
//     begin
//         IF SalesCrMemoHeader.GET(DocumentNo) THEN
//         IsInvoice := FALSE;
//     end;

//     local procedure GetGSTCompRate(DocNo: Code[20];LineNo: Integer;var CgstRt: Decimal;var SgstRt: Decimal;var IgstRt: Decimal;var CesRt: Decimal;var CesNonAdval: Decimal;var StateCes: Decimal)
//     var
//         DetailedGSTLedgerEntry: Record "16419";
//         GSTComponent: Record "16405";
//     begin
//         DetailedGSTLedgerEntry.SETRANGE("Document No.",DocNo);
//         DetailedGSTLedgerEntry.SETRANGE("Document Line No.",LineNo);

//         DetailedGSTLedgerEntry.SETRANGE("GST Component Code",'CGST');
//         IF DetailedGSTLedgerEntry.FINDFIRST THEN
//           CgstRt := DetailedGSTLedgerEntry."GST %"
//         ELSE
//           CgstRt := 0;

//         DetailedGSTLedgerEntry.SETRANGE("GST Component Code",'SGST');
//         IF DetailedGSTLedgerEntry.FINDFIRST THEN
//           SgstRt := DetailedGSTLedgerEntry."GST %"
//         ELSE
//           SgstRt := 0;

//         DetailedGSTLedgerEntry.SETRANGE("GST Component Code",'IGST');
//         IF DetailedGSTLedgerEntry.FINDFIRST THEN
//           IgstRt := DetailedGSTLedgerEntry."GST %"
//         ELSE
//           IgstRt := 0;

//         CesRt := 0;
//         CesNonAdval := 0;
//         DetailedGSTLedgerEntry.SETRANGE("GST Component Code",'CESS');
//         IF DetailedGSTLedgerEntry.FINDFIRST THEN
//           IF DetailedGSTLedgerEntry."GST %" > 0 THEN
//             CesRt := DetailedGSTLedgerEntry."GST %"
//           ELSE
//             CesNonAdval := ABS(DetailedGSTLedgerEntry."GST Amount");

//         DetailedGSTLedgerEntry.SETRANGE("GST Component Code",'INTERCESS');
//         IF DetailedGSTLedgerEntry.FINDFIRST THEN
//           CesRt := DetailedGSTLedgerEntry."GST %";

//         StateCes := 0;
//         DetailedGSTLedgerEntry.SETRANGE("GST Component Code");
//         IF DetailedGSTLedgerEntry.FINDSET THEN
//           REPEAT
//             IF NOT (DetailedGSTLedgerEntry."GST Component Code" IN ['CGST','SGST','IGST','CESS','INTERCESS'])
//             THEN
//               IF GSTComponent.GET(DetailedGSTLedgerEntry."GST Component Code") THEN
//                 //Start DJ Commented STD code
//                 /*
//                 IF GSTComponent."Exclude from Reports" THEN
//                   StateCes := DetailedGSTLedgerEntry."GST %";
//                   */
//                   StateCes := 0;
//                   //DJ Commented STD code END
//           UNTIL DetailedGSTLedgerEntry.NEXT = 0;

//     end;

//     local procedure GetGSTVal(var AssVal: Decimal;var CgstVal: Decimal;var SgstVal: Decimal;var IgstVal: Decimal;var CesVal: Decimal;var StCesVal: Decimal;var CesNonAdval: Decimal;var Disc: Decimal;var OthChrg: Decimal;var TotInvVal: Decimal;DocumentNo: Code[20];LineNo: Integer)
//     var
//         SalesInvoiceLine: Record "113";
//         SalesCrMemoLine: Record "115";
//         GSTLedgerEntry: Record "16418";
//         DetailedGSTLedgerEntry: Record "16419";
//         CurrExchRate: Record "330";
//         CustLedgerEntry: Record "21";
//         GSTComponent: Record "16405";
//         TotGSTAmt: Decimal;
//         PosStrOrderLine: Record "13798";
//     begin
//         OthChrg := 0;
//         DetailedGSTLedgerEntry.SETRANGE("Document No.",DocumentNo);
//         DetailedGSTLedgerEntry.SETRANGE("Document Line No.",LineNo);
//         DetailedGSTLedgerEntry.SETRANGE("GST Component Code",'CGST');
//         IF DetailedGSTLedgerEntry.FINDSET THEN BEGIN
//           REPEAT
//             CgstVal := ABS(DetailedGSTLedgerEntry."GST Amount");
//           UNTIL DetailedGSTLedgerEntry.NEXT = 0;
//         END ELSE
//           CgstVal := 0;

//         DetailedGSTLedgerEntry.SETFILTER("GST Component Code",'%1|%2','SGST','UTGST');
//         IF DetailedGSTLedgerEntry.FINDSET THEN BEGIN
//           REPEAT
//             SgstVal := ABS(DetailedGSTLedgerEntry."GST Amount")
//           UNTIL DetailedGSTLedgerEntry.NEXT = 0;
//         END ELSE
//           SgstVal := 0;

//         DetailedGSTLedgerEntry.SETRANGE("GST Component Code",'IGST');
//         IF DetailedGSTLedgerEntry.FINDSET THEN BEGIN
//           REPEAT
//             IgstVal := ABS(DetailedGSTLedgerEntry."GST Amount")
//           UNTIL DetailedGSTLedgerEntry.NEXT = 0;
//         END ELSE
//           IgstVal := 0;

//         CesVal := 0;
//         CesNonAdval := 0;
//         /*
//         DetailedGSTLedgerEntry.SETRANGE("GST Component Code",'INTERCESS');
//         IF DetailedGSTLedgerEntry.FINDSET THEN
//           REPEAT
//             CesVal := ABS(DetailedGSTLedgerEntry."GST Amount")
//           UNTIL DetailedGSTLedgerEntry.NEXT = 0;

//         DetailedGSTLedgerEntry.SETRANGE("Document No.",DocumentNo);
//         DetailedGSTLedgerEntry.SETRANGE("GST Component Code",'CESS');
//         IF DetailedGSTLedgerEntry.FINDFIRST THEN
//           REPEAT
//             IF DetailedGSTLedgerEntry."GST %" > 0 THEN
//               CesVal := ABS(DetailedGSTLedgerEntry."GST Amount")
//             ELSE
//               CesNonAdval += ABS(DetailedGSTLedgerEntry."GST Amount");
//           UNTIL GSTLedgerEntry.NEXT = 0;

//         DetailedGSTLedgerEntry.SETFILTER("GST Component Code",'<>CGST|<>SGST|<>IGST|<>CESS|<>INTERCESS');
//         IF DetailedGSTLedgerEntry.FINDSET THEN BEGIN
//           REPEAT
//             IF GSTComponent.GET(DetailedGSTLedgerEntry."GST Component Code") THEN
//               // Start DJ Commented STD code
//               {
//               IF GSTComponent."Exclude from Reports" THEN
//                 StCesVal := ABS(DetailedGSTLedgerEntry."GST Amount");
//                }
//                //DJ Commented STD code END
//                StCesVal := 0;
//           UNTIL DetailedGSTLedgerEntry.NEXT = 0;
//         END;
//         */
//         IF IsInvoice THEN BEGIN
//           SalesInvoiceLine.SETRANGE("Document No.",DocumentNo);
//           SalesInvoiceLine.SETRANGE("Line No.",LineNo);
//           IF SalesInvoiceLine.FINDSET THEN BEGIN
//             REPEAT
//             /*
//               AssVal += SalesInvoiceLine."GST Base Amount";
//               TotGSTAmt += SalesInvoiceLine."Total GST Amount";
//               Disc += SalesInvoiceLine."Inv. Discount Amount";
//               TotInvVal += SalesInvoiceLine."Amount To Customer";
//               */
//             AssVal += ROUND(
//                 CurrExchRate.ExchangeAmtFCYToLCY(
//                   WORKDATE,SalesInvoiceHeader."Currency Code",SalesInvoiceLine."GST Base Amount",SalesInvoiceHeader."Currency Factor"),0.01,'=');
//             TotGSTAmt += ROUND(
//                 CurrExchRate.ExchangeAmtFCYToLCY(
//                   WORKDATE,SalesInvoiceHeader."Currency Code",SalesInvoiceLine."Total GST Amount",SalesInvoiceHeader."Currency Factor"),0.01,'=');
//             Disc += ROUND(
//                 CurrExchRate.ExchangeAmtFCYToLCY(
//                   WORKDATE,SalesInvoiceHeader."Currency Code",SalesInvoiceLine."Inv. Discount Amount",SalesInvoiceHeader."Currency Factor"),0.01,'=');
//             TotInvVal += ROUND(
//                CurrExchRate.ExchangeAmtFCYToLCY(
//                  WORKDATE,SalesInvoiceHeader."Currency Code",SalesInvoiceLine."Amount To Customer",SalesInvoiceHeader."Currency Factor"),0.01,'=');

//             UNTIL SalesInvoiceLine.NEXT = 0;
//           END;
//             /*
//             AssVal := ROUND(
//                 CurrExchRate.ExchangeAmtFCYToLCY(
//                   WORKDATE,SalesInvoiceHeader."Currency Code",AssVal,SalesInvoiceHeader."Currency Factor"),0.01,'=');
//             TotGSTAmt := ROUND(
//                 CurrExchRate.ExchangeAmtFCYToLCY(
//                   WORKDATE,SalesInvoiceHeader."Currency Code",TotGSTAmt,SalesInvoiceHeader."Currency Factor"),0.01,'=');
//             Disc := ROUND(
//                 CurrExchRate.ExchangeAmtFCYToLCY(
//                   WORKDATE,SalesInvoiceHeader."Currency Code",Disc,SalesInvoiceHeader."Currency Factor"),0.01,'=');
//             TotInvVal := ROUND(
//                CurrExchRate.ExchangeAmtFCYToLCY(
//                  WORKDATE,SalesInvoiceHeader."Currency Code",TotInvVal,SalesInvoiceHeader."Currency Factor"),0.01,'=');
//               */
//             PosStrOrderLine.RESET;
//             PosStrOrderLine.SETRANGE(Type,PosStrOrderLine.Type::Sale);
//             PosStrOrderLine.SETRANGE("Document Type",PosStrOrderLine."Document Type"::Invoice);
//             PosStrOrderLine.SETRANGE("Tax/Charge Type",PosStrOrderLine."Tax/Charge Type"::Charges);
//             PosStrOrderLine.SETFILTER("Tax/Charge Group",'<>%1','CESS');//DJ 25112020 INV-I/20/CL/2021/518
//             PosStrOrderLine.SETRANGE("Invoice No.",DocumentNo);
//             PosStrOrderLine.SETRANGE("Line No.",LineNo);
//             IF PosStrOrderLine.FINDFIRST THEN
//               REPEAT
//                 OthChrg += PosStrOrderLine."Amount (LCY)";
//               UNTIL PosStrOrderLine.NEXT= 0;

//             PosStrOrderLine.RESET;
//             PosStrOrderLine.SETRANGE(Type,PosStrOrderLine.Type::Sale);
//             PosStrOrderLine.SETRANGE("Document Type",PosStrOrderLine."Document Type"::Invoice);
//             PosStrOrderLine.SETFILTER("Tax/Charge Group",'=%1','CESS');//DJ 25112020 INV-I/20/CL/2021/518
//             ////DJ 25112020 INV-I/20/CL/2021/518 PosStrOrderLine.SETRANGE("Tax/Charge Type",PosStrOrderLine."Tax/Charge Type"::"Other Taxes");
//             PosStrOrderLine.SETRANGE("Invoice No.",DocumentNo);
//             PosStrOrderLine.SETRANGE("Line No.",LineNo);
//             IF PosStrOrderLine.FINDFIRST THEN
//               REPEAT
//                 CesNonAdval += PosStrOrderLine."Amount (LCY)";
//               UNTIL PosStrOrderLine.NEXT= 0;

//         END ELSE BEGIN
//           SalesCrMemoLine.SETRANGE("Document No.",DocumentNo);
//           SalesCrMemoLine.SETRANGE("Line No.",LineNo);
//           IF SalesCrMemoLine.FINDSET THEN BEGIN
//             REPEAT
//             /*
//               AssVal += SalesCrMemoLine."GST Base Amount";
//               TotGSTAmt += SalesCrMemoLine."Total GST Amount";
//               Disc += SalesCrMemoLine."Inv. Discount Amount";
//               TotInvVal +=  SalesCrMemoLine."Amount To Customer";
//             */

//           AssVal += ROUND(
//               CurrExchRate.ExchangeAmtFCYToLCY(
//                 WORKDATE,SalesCrMemoHeader."Currency Code",SalesCrMemoLine."GST Base Amount",SalesCrMemoHeader."Currency Factor"),0.01,'=');
//           TotGSTAmt += ROUND(
//               CurrExchRate.ExchangeAmtFCYToLCY(
//                 WORKDATE,SalesCrMemoHeader."Currency Code",SalesCrMemoLine."Total GST Amount",SalesCrMemoHeader."Currency Factor"),0.01,'=');
//           Disc += ROUND(
//               CurrExchRate.ExchangeAmtFCYToLCY(
//                 WORKDATE,SalesCrMemoHeader."Currency Code",SalesCrMemoLine."Inv. Discount Amount",SalesCrMemoHeader."Currency Factor"),0.01,'=');
//           TotInvVal += ROUND(
//               CurrExchRate.ExchangeAmtFCYToLCY(
//                 WORKDATE,SalesCrMemoHeader."Currency Code",SalesCrMemoLine."Amount To Customer",SalesCrMemoHeader."Currency Factor"),0.01,'=');

//             UNTIL SalesCrMemoLine.NEXT = 0;
//           END;
//           /*
//           AssVal := ROUND(
//               CurrExchRate.ExchangeAmtFCYToLCY(
//                 WORKDATE,SalesCrMemoHeader."Currency Code",AssVal,SalesCrMemoHeader."Currency Factor"),0.01,'=');
//           TotGSTAmt := ROUND(
//               CurrExchRate.ExchangeAmtFCYToLCY(
//                 WORKDATE,SalesCrMemoHeader."Currency Code",TotGSTAmt,SalesCrMemoHeader."Currency Factor"),0.01,'=');
//           Disc := ROUND(
//               CurrExchRate.ExchangeAmtFCYToLCY(
//                 WORKDATE,SalesCrMemoHeader."Currency Code",Disc,SalesCrMemoHeader."Currency Factor"),0.01,'=');
//           TotInvVal := ROUND(
//              CurrExchRate.ExchangeAmtFCYToLCY(
//                 WORKDATE,SalesCrMemoHeader."Currency Code",TotInvVal,SalesCrMemoHeader."Currency Factor"),0.01,'=');
//            */
//            PosStrOrderLine.RESET;
//            PosStrOrderLine.SETRANGE(Type,PosStrOrderLine.Type::Sale);
//            PosStrOrderLine.SETFILTER("Document Type",'%1|%2',PosStrOrderLine."Document Type"::"Credit Memo",PosStrOrderLine."Document Type"::"Return Order");
//            PosStrOrderLine.SETRANGE("Tax/Charge Type",PosStrOrderLine."Tax/Charge Type"::Charges);
//            PosStrOrderLine.SETFILTER("Tax/Charge Group",'<>%1','CESS');//DJ 25112020 INV-I/20/CL/2021/518
//            PosStrOrderLine.SETRANGE("Invoice No.",DocumentNo);
//            PosStrOrderLine.SETRANGE("Line No.",LineNo);
//            IF PosStrOrderLine.FINDFIRST THEN
//              REPEAT
//                OthChrg += PosStrOrderLine."Amount (LCY)";
//              UNTIL PosStrOrderLine.NEXT= 0;

//            PosStrOrderLine.RESET;
//            PosStrOrderLine.SETRANGE(Type,PosStrOrderLine.Type::Sale);
//            PosStrOrderLine.SETFILTER("Document Type",'%1|%2',PosStrOrderLine."Document Type"::"Credit Memo",PosStrOrderLine."Document Type"::"Return Order");
//            PosStrOrderLine.SETFILTER("Tax/Charge Group",'=%1','CESS');//DJ 25112020 INV-I/20/CL/2021/518
//            //DJ 25112020 INV-I/20/CL/2021/518 PosStrOrderLine.SETRANGE("Tax/Charge Type",PosStrOrderLine."Tax/Charge Type"::"Other Taxes");
//            PosStrOrderLine.SETRANGE("Invoice No.",DocumentNo);
//            PosStrOrderLine.SETRANGE("Line No.",LineNo);
//            IF PosStrOrderLine.FINDFIRST THEN
//              REPEAT
//                CesNonAdval += PosStrOrderLine."Amount (LCY)";
//              UNTIL PosStrOrderLine.NEXT= 0;

//             //RSPLAM030523
//             IF OthChrg <> 0 THEN
//              //TotInvVal:= TotInvVal-OthChrg;   //tempcomment vijay
//              TotInvVal:= TotInvVal;
//             //RSPLAM030523
//         END;


//         /*
//         CustLedgerEntry.SETCURRENTKEY("Document No.");
//         CustLedgerEntry.SETRANGE("Document No.",DocumentNo);
//         IF IsInvoice THEN BEGIN
//           CustLedgerEntry.SETRANGE("Document Type",CustLedgerEntry."Document Type"::Invoice);
//           CustLedgerEntry.SETRANGE("Customer No.",SalesInvoiceHeader."Bill-to Customer No.");
//         END ELSE BEGIN
//           CustLedgerEntry.SETRANGE("Document Type",CustLedgerEntry."Document Type"::"Credit Memo");
//           CustLedgerEntry.SETRANGE("Customer No.",SalesCrMemoHeader."Bill-to Customer No.");
//         END;
//         IF CustLedgerEntry.FINDFIRST THEN BEGIN
//           CustLedgerEntry.CALCFIELDS("Amount (LCY)");
//           TotInvVal := ABS(CustLedgerEntry."Amount (LCY)");
//         END;
//         */

//     end;

//     [Scope('Internal')]
//     procedure SetLocation(LocationVar: Code[20])
//     begin
//         LocVar := LocationVar;
//     end;

//     [Scope('Internal')]
//     procedure DynamicJsonTransferReturn(txtDocNo: Text) IRNJson: Text
//     var
//         NoSeriesMgt: Codeunit "396";
//         cdNo: Code[20];
//         cdNoSeries: Code[20];
//         Catg: Text;
//         RegRev: Text;
//         Typ: Text;
//         DocType: Text;
//         DocDate: Text;
//         LocRec: Record "14";
//         StateRec: Record "13762";
//         CustomerRec: Record "18";
//         StateCd: Integer;
//         StateRec2: Record "13762";
//         AssVal: Decimal;
//         CgstVal: Decimal;
//         SgstVal: Decimal;
//         IgstVal: Decimal;
//         CesVal: Decimal;
//         StCesVal: Decimal;
//         CesNonAdval: Decimal;
//         Disc: Decimal;
//         OthChrg: Decimal;
//         TotInvVal: Decimal;
//         Trsnsdtls: Text;
//         DocDtls: Text;
//         SellerDtls: Text;
//         BuyerDtls: Text;
//         ValDtls: Text;
//         ItemListDtls: Text;
//         DispDtls: Text;
//         ShipDtls: Text;
//         TaxSchema: Text;
//         ItemListValuesDtls: Text;
//         SalesInvoiceLine: Record "113";
//         SalesCrMemoLine: Record "115";
//         AssAmt: Decimal;
//         CgstRt: Decimal;
//         SgstRt: Decimal;
//         IgstRt: Decimal;
//         CesRt: Decimal;
//         CesNonAdval2: Decimal;
//         StateCes: Decimal;
//         FreeQty: Decimal;
//         SNo: Integer;
//         StateRec3: Record "13762";
//         Shiptoadd: Record "222";
//         ValueEntry: Record "5802";
//         ItemLedgerEntry: Record "32";
//         ValueEntryRelation: Record "6508";
//         ItemTrackingManagement: Codeunit "6500";
//         InvoiceRowID: Text[250];
//         BchDtls: Text;
//         TotalSGSTAmt: Decimal;
//         TotalCGSTAmt: Decimal;
//         TotalIGSTAmt: Decimal;
//         ISServc: Text;
//         ShipGSTIN: Text;
//         ShipStcd: Text;
//         ShipPincode: Text;
//         ItemRec: Record "27";
//         recUnitofMeasure: Record "204";
//         qtyUnit: Code[10];
//         ShipToAddress: Record "222";
//         PayDtls: Text;
//         CustomerRec2: Record "18";
//         BankAccount: Record "270";
//         Ewbdtls: Text;
//         TranporterRec: Record "50046";
//         ShipMethodRec: Record "10";
//         ExpDtls: Text;
//         RefDtls: Text;
//         AddlDocDtls: Text;
//         CustLedEntry: Record "21";
//         PaymentDue: Decimal;
//         SellerPhoneNo: Text;
//         SellerEmail: Text;
//         BuyerPhoneNo: Text;
//         BuyerEmail: Text;
//         BuyerGstin: Text[20];
//         BuyerPos: Text[20];
//         BuyerStcd: Text[20];
//         BuyerPincode: Text[20];
//         CurrExchRate: Record "330";
//         TotAmt: Decimal;
//         TotalItemVal: Decimal;
//         HSNRec: Record "16411";
//         LocRec2: Record "14";
//         TransferShipHead: Record "5744";
//         TransferShipLine: Record "5745";
//         GstSetup: Record "16408";
//         GSTRate: Decimal;
//         CompanyInfo: Record "79";
//     begin
//         SNo := 0;
//         InitializeVariables;
//         TransferShipHead.GET(txtDocNo);
//         DocType := 'INV';
//         DocDate:=FORMAT(TransferShipHead."Posting Date",0,'<Day,2>/<Month,2>/<Year4>');
//         IF LocRec.GET(TransferShipHead."Transfer-from Code") THEN;
//         IF LocRec2.GET(TransferShipHead."Transfer-to Code") THEN;
//         IF StateRec.GET(LocRec."State Code") THEN;
//         IF StateRec2.GET(LocRec2."State Code") THEN;
//         IF ShipMethodRec.GET(TransferShipHead."Shipment Method Code") THEN;
//         IF CompanyInfo.GET THEN   //AR05NOV20

//         TaxSchema := '{'
//         +'  "Version": "1.1",' ;

//         Trsnsdtls := '  "TranDtls": {'
//         +'    "TaxSch": "GST",'
//         +'    "SupTyp": "' + 'B2B' + '"'
//         //+'    "RegRev": "'+ RegRev +'",'
//         //+'    "Typ": "REG",   '
//         //+'    "EcmTrn": "N",'
//         //+'    "EcmGstin": null,'
//         //+'    "IgstOnIntra": "N"'
//         +' },' ;

//         DocDtls := '  "DocDtls": {'
//         +'    "Typ": "'+DocType+'",'
//         +'    "No": "' + txtDocNo + '",'
//         +'    "Dt": "'+ DocDate +'"'
//         +'  },';

//         SellerDtls := '  "SellerDtls": {'
//         +'    "Gstin": "'+LocRec."GST Registration No."+'",'
//         //+'    "LglNm": "'+ LocRec.Name +'",'     //AR05NOV20
//         //+'    "TrdNm": "'+ LocRec.Name +'",'     //AR05NOV20
//         +'    "LglNm": "'+ CompanyInfo.Name +'",'  //AR05NOV20
//         +'    "TrdNm": "'+ CompanyInfo.Name +'",'  //AR05NOV20
//         +'    "Addr1": "'+LocRec.Address+'"';
//         IF LocRec."Address 2" <> '' THEN
//           SellerDtls := SellerDtls + ',' +'    "Addr2": "'+LocRec."Address 2"+'"'
//         ELSE
//           SellerDtls := SellerDtls;
//         SellerDtls := SellerDtls+ ',' +'    "Loc": "'+LocRec.City+'"';

//         IF (LocRec."Post Code" <> '') THEN BEGIN
//           SellerDtls :=SellerDtls + ',' +'    "Pin": '+LocRec."Post Code"+'';
//         END ELSE
//           SellerDtls :=SellerDtls;
//         IF StateRec."State Code (GST Reg. No.)" <> '' THEN BEGIN
//           SellerDtls :=SellerDtls + ',' +'    "Stcd": "'+StateRec."State Code (GST Reg. No.)"+'"';
//         END ELSE
//           SellerDtls :=SellerDtls;

//         IF LocRec."Phone No." <> '' THEN BEGIN
//           SellerPhoneNo := '"Ph": "'+LocRec."Phone No."+'"';
//           SellerDtls :=SellerDtls + ',' + SellerPhoneNo;
//         END ELSE
//           SellerDtls :=SellerDtls;

//         IF LocRec."E-Mail" <> '' THEN BEGIN
//           SellerEmail := 'Em": "'+LocRec."E-Mail"+'"';
//           SellerDtls :=SellerDtls + ',"'+SellerEmail;
//         END ELSE
//           SellerDtls := SellerDtls;
//         SellerDtls := SellerDtls +'  },';

//         BuyerDtls := '  "BuyerDtls": {'
//         +'    "Gstin": "'+ LocRec2."GST Registration No." +'",'
//         +'    "LglNm": "'+ LocRec2.Name +'",'
//         +'    "TrdNm": "'+ LocRec2.Name +'",'
//         +'    "Pos": "'+ StateRec2."State Code (GST Reg. No.)" +'",'
//         +'    "Addr1": "'+ LocRec2.Address +'"';

//         IF LocRec2."Address 2" <> '' THEN BEGIN
//           BuyerDtls :=BuyerDtls + ',' +'    "Addr2": "'+ LocRec2."Address 2" +'"';
//         END ELSE
//           BuyerDtls :=BuyerDtls;

//         BuyerDtls :=BuyerDtls + ',' +'    "Loc": "'+LocRec.City+'"';

//         IF (LocRec2."Post Code") <> '' THEN BEGIN
//           BuyerDtls :=BuyerDtls + ',' +'    "Pin": '+ LocRec2."Post Code" +'';
//         END ELSE
//           BuyerDtls :=BuyerDtls;

//         IF StateRec2."State Code (GST Reg. No.)" <> '' THEN BEGIN
//           BuyerDtls :=BuyerDtls + ',' +'    "Stcd": "'+ StateRec2."State Code (GST Reg. No.)" +'"';
//         END ELSE
//           BuyerDtls :=BuyerDtls;

//         IF LocRec2."Phone No." <> '' THEN BEGIN
//           BuyerPhoneNo := '"Ph": "'+LocRec2."Phone No."+'"';
//           BuyerDtls :=BuyerDtls + ',' + BuyerPhoneNo;
//         END ELSE
//           BuyerDtls :=BuyerDtls;

//         IF LocRec2."E-Mail" <> '' THEN BEGIN
//           BuyerEmail := 'Em": "'+LocRec2."E-Mail"+'"';
//           BuyerDtls :=BuyerDtls + ',"'+BuyerEmail;
//         END ELSE
//           BuyerDtls:= BuyerDtls;
//         BuyerDtls:= BuyerDtls+'  },';

//         DispDtls := '  "DispDtls": {'
//         +'    "Nm": "'+ LocRec.Name +'",'
//         +'    "Addr1": "'+LocRec.Address+'"';
//         IF LocRec."Address 2" <> '' THEN
//           DispDtls := DispDtls  + ',' +'    "Addr2": "'+LocRec."Address 2"+'"'
//         ELSE
//           DispDtls := DispDtls;
//         DispDtls := DispDtls + ',' +'    "Loc": "'+LocRec.City+'"';

//         IF (LocRec."Post Code" <> '') THEN BEGIN
//           DispDtls := DispDtls + ',' +'    "Pin": '+LocRec."Post Code"+'';
//         END ELSE
//           DispDtls := DispDtls;
//         IF StateRec."State Code (GST Reg. No.)" <> '' THEN BEGIN
//           DispDtls := DispDtls + ',' +'    "Stcd": "'+StateRec."State Code (GST Reg. No.)"+'"';
//         END ELSE
//           DispDtls := DispDtls;
//         DispDtls := DispDtls +'  },';

//           ShipDtls :=  '"ShipDtls": {'
//           +'    "Gstin": "'+LocRec2."GST Registration No."+'",'
//           +'    "LglNm": "'+ LocRec2.Name +'",'
//           +'    "TrdNm": "'+ LocRec2.Name +'",'
//           +'    "Addr1": "'+ LocRec2.Address +'"';
//           IF LocRec2."Address 2" <> '' THEN
//             ShipDtls := ShipDtls + ','+'    "Addr2": "'+ LocRec2."Address 2" +'"'
//           ELSE
//             ShipDtls := ShipDtls;
//         ShipDtls := ShipDtls + ',' +'    "Loc": "'+LocRec2.City+'"';

//         IF (LocRec2."Post Code") <> '' THEN BEGIN
//           ShipDtls := ShipDtls + ',' +'    "Pin": '+ LocRec2."Post Code" +'';
//         END ELSE
//           ShipDtls := ShipDtls;

//         IF StateRec2."State Code (GST Reg. No.)" <> '' THEN BEGIN
//           ShipDtls := ShipDtls + ',' +'    "Stcd": "'+ StateRec2."State Code (GST Reg. No.)" +'"';
//         END ELSE
//           ShipDtls := ShipDtls;

//         ShipDtls := ShipDtls  +'  },';

//         ItemListDtls := ItemListDtls +'"ItemList": [';

//         TransferShipLine.SETRANGE("Document No.",txtDocNo);
//         TransferShipLine.SETFILTER("Item No.",'<>%1','');
//         TransferShipLine.SETFILTER(Quantity,'<>%1',0);
//         TransferShipLine.SETFILTER(Amount,'>%1',1);
//         IF TransferShipLine.FINDSET THEN BEGIN
//           IF (TransferShipLine.COUNT > 100) THEN
//             ERROR(SalesLinesErr,TransferShipLine.COUNT);
//           REPEAT
//             BchDtls := '';
//             SNo += 1;
//             AssAmt := 0;
//             TotAmt := 0;
//             GetGSTCompRate(TransferShipLine."Document No.",TransferShipLine."Line No.",
//               CgstRt,SgstRt,IgstRt,CesRt,CesNonAdval,StateCes);
//             GetGSTVal(AssVal,CgstVal,SgstVal,IgstVal,CesVal,StCesVal,CesNonAdval,Disc,OthChrg,TotInvVal,txtDocNo,TransferShipLine."Line No.");
//             AssAmt := TransferShipLine."GST Base Amount";
//             TotAmt := TransferShipLine."GST Base Amount"+OthChrg;
//             TotalItemVal := TransferShipLine."GST Base Amount"+OthChrg + TransferShipLine."Total GST Amount";
//             IF HSNRec.GET(TransferShipLine."GST Group Code",TransferShipLine."HSN/SAC Code") THEN BEGIN
//               IF HSNRec.Type = HSNRec.Type::HSN THEN
//                 ISServc := 'N'
//               ELSE
//                 ISServc := 'Y'
//             END;

//             GstSetup.RESET;
//             GstSetup.SETRANGE("GST Group Code",TransferShipLine."GST Group Code");
//             GstSetup.SETRANGE("GST Jurisdiction Type",GstSetup."GST Jurisdiction Type"::Interstate);
//             IF GstSetup.FINDFIRST THEN
//               GSTRate := GstSetup."GST Component %";

//             ItemListDtls += '{'
//             +'      "SlNo": "'+FORMAT(SNo)+'",'
//             +'      "IsServc": "'+ISServc+'",'
//             +'      "PrdDesc": "'+TransferShipLine.Description+'",'
//             +'      "HsnCd": "'+TransferShipLine."HSN/SAC Code"+'",';

//             InvoiceRowID := ItemTrackingManagement.ComposeRowID(DATABASE::"Transfer Shipment Line",0,txtDocNo,'',0,TransferShipLine."Line No.");
//             ValueEntryRelation.SETCURRENTKEY("Source RowId");
//             ValueEntryRelation.SETRANGE("Source RowId",InvoiceRowID);
//             IF ValueEntryRelation.FINDSET THEN BEGIN
//               REPEAT
//                 ValueEntry.GET(ValueEntryRelation."Value Entry No.");
//                 ItemLedgerEntry.GET(ValueEntry."Item Ledger Entry No.");
//                   BchDtls +=' "BchDtls": {'
//                     +'      "Nm": "'+COPYSTR(ItemLedgerEntry."Lot No." + ItemLedgerEntry."Serial No.",1,20)+'"'
//                     //+'      "ExpDt": "'+FORMAT(TODAY,0,'<Day,2>/<Month,2>/<Year4>')+'",'
//                     //+'      "WrDt": "'+FORMAT(TODAY,0,'<Day,2>/<Month,2>/<Year4>')+'"'
//                     // +'      "ExpDt": "'+FORMAT(ItemLedgerEntry."Expiration Date",0,'<Day,2>/<Month,2>/<Year4>')+'",'
//                     // +'      "WrDt": "'+FORMAT(ItemLedgerEntry."Warranty Date",0,'<Day,2>/<Month,2>/<Year4>')+'"'
//                     +'  },';
//               UNTIL ValueEntryRelation.NEXT = 0;
//             END;
//             IF ItemRec.GET(TransferShipLine."Item No.") THEN;
//             IF recUnitofMeasure.GET(ItemRec."Base Unit of Measure")  THEN
//               qtyUnit := recUnitofMeasure."GST Reporting UQC";

//             ItemListDtls := ItemListDtls + BchDtls;
//             ItemListDtls += '"Qty": '+DELCHR(FORMAT(TransferShipLine.Quantity), '=',',')+','
//             +'      "Unit": "'+qtyUnit+'",'
//             +'      "UnitPrice": '+DELCHR(FORMAT(ROUND((TransferShipLine."Unit Price"),0.01,'=')), '=',',')+','
//             +'      "TotAmt": '+DELCHR(FORMAT(TotAmt), '=',',')+','
//             +'      "Discount":'+DELCHR(FORMAT(0), '=',',')+','
//             +'      "AssAmt":'+DELCHR(FORMAT(AssAmt), '=',',')+','
//             //+'      "GstRt": '+DELCHR(FORMAT(ROUND((TransferShipLine."GST %"),1,'='),0,2), '=',',')+','
//             +'      "GstRt": '+DELCHR(FORMAT(GSTRate), '=',',')+','
//             +'      "SgstAmt": '+DELCHR(FORMAT(SgstVal), '=',',')+','
//             +'      "IgstAmt": '+DELCHR(FORMAT(IgstVal), '=',',')+','
//             +'      "CgstAmt": '+DELCHR(FORMAT(CgstVal), '=',',')+','
//             +'      "CesRt": '+DELCHR(FORMAT(CesRt), '=',',')+','
//             +'      "CesAmt": '+DELCHR(FORMAT(CesVal), '=',',')+','
//             +'      "CesNonAdvlAmt": '+DELCHR(FORMAT(CesNonAdval), '=',',')+','
//             +'      "StateCesRt": '+DELCHR(FORMAT(StateCes), '=',',')+','
//             +'      "StateCesAmt": '+DELCHR(FORMAT(StCesVal), '=',',')+','
//             +'      "StateCesNonAdvlAmt": '+DELCHR(FORMAT(0), '=',',')+','
//             //+'    "OthChrg": '+DELCHR(FORMAT(OthChrg), '=',',')+','
//             +'      "OthChrg": '+DELCHR(FORMAT(0), '=',',')+','
//             +'      "TotItemVal": '+DELCHR(FORMAT(TotalItemVal), '=',',')+''
//             +'    },' ;
//             TotalSGSTAmt +=SgstVal;
//             TotalIGSTAmt +=IgstVal;
//             TotalCGSTAmt +=CgstVal;
//             AssVal += AssAmt;
//             TotInvVal += TotalItemVal;
//           UNTIL TransferShipLine.NEXT = 0;
//           ItemListDtls  :=  COPYSTR(ItemListDtls, 1,  STRLEN(ItemListDtls)-1);
//           ItemListDtls +=  '],';
//         END;

//          ValDtls := '"ValDtls": {'
//          +'    "AssVal": '+DELCHR(FORMAT(AssVal), '=',',')+','
//          +'    "SgstVal": '+DELCHR(FORMAT(TotalSGSTAmt), '=',',')+','
//          +'    "CgstVal": '+DELCHR(FORMAT(TotalCGSTAmt), '=',',')+','
//          +'    "IgstVal": '+DELCHR(FORMAT(TotalIGSTAmt), '=',',')+','
//          +'    "CesVal": '+DELCHR(FORMAT(CesVal), '=',',')+','
//          +'    "StCesVal": '+DELCHR(FORMAT(StCesVal), '=',',')+','
//          +'    "RndOffAmt": null,'
//          +'    "TotInvVal": '+DELCHR(FORMAT(TotInvVal), '=',',')+''
//          +'}';

//         Ewbdtls := '}';
//         IRNJson := TaxSchema + Trsnsdtls + DocDtls + SellerDtls + BuyerDtls +DispDtls + ShipDtls + ItemListDtls + ValDtls + PayDtls + RefDtls + AddlDocDtls + ExpDtls + Ewbdtls;
//     end;

//     [Scope('Internal')]
//     procedure "---------QrCode--------BEGIN"()
//     begin
//     end;

//     [Scope('Internal')]
//     procedure CreateQRCode(QRCodeInput: Text;var TempBLOB: Record "99008535")
//     var
//         QRCodeFileName: Text;
//     begin
//         CLEAR(TempBLOB);
//         QRCodeFileName := GetQRCode(QRCodeInput);
//         UploadFileBLOBImportandDeleteServerFile(TempBLOB,QRCodeFileName);
//     end;

//     [Scope('Internal')]
//     procedure BarcodeForQuarantineLabel(QRCodeInput: Text;var TempBlob: Record "99008535")
//     var
//         recSIL1: Record "113";
//         ItemLedgEntry_lRec: Record "32";
//         Text5000_Ctx: Label '<xpml><page quantity=''0'' pitch=''74.1 mm''></xpml>SIZE 100 mm, 74.1 mm';
//         Text5001_Ctx: Label 'DIRECTION 0,0';
//         Text5002_Ctx: Label 'REFERENCE 0,0';
//         Text5003_Ctx: Label 'OFFSET 0 mm';
//         Text5004_Ctx: Label 'SET PEEL OFF';
//         Text5005_Ctx: Label 'SET CUTTER OFF';
//         Text5006_Ctx: Label 'SET PARTIAL_CUTTER OFF';
//         Text5007_Ctx: Label '<xpml></page></xpml><xpml><page quantity=''1'' pitch=''74.1 mm''></xpml>SET TEAR ON';
//         Text5008_Ctx: Label 'CLS';
//         Text5009_Ctx: Label 'CODEPAGE 1252';
//         Text5010_Ctx: Label 'TEXT 806,792,"0",180,17,14,"SCHILLER_"';
//         Text5011_Ctx: Label 'TEXT 1093,443,"0",180,14,12,"Item"';
//         Text5012_Ctx: Label 'TEXT 1093,303,"0",180,10,12,"Part No."';
//         Text5013_Ctx: Label 'TEXT 1093,166,"0",180,12,12,"Sr. No."';
//         Text5014_Ctx: Label 'TEXT 933,443,"0",180,14,12,":"';
//         Text5015_Ctx: Label 'TEXT 933,303,"0",180,14,12,":"';
//         Text5016_Ctx: Label 'TEXT 933,166,"0",180,14,12,":"';
//         Text5017_Ctx: Label 'TEXT 896,303,"0",180,10,12,"%1"';
//         Text5018_Ctx: Label 'TEXT 896,166,"0",180,10,12,"%1"';
//         Text5019_Ctx: Label 'QRCODE 330,300,L,10,A,180,M2,S7,"%1"';
//         Text5020_Ctx: Label 'TEXT 896,443,"0",180,10,12,"%1"';
//         Text5021_Ctx: Label 'PRINT 1,1';
//         Text5022_Ctx: Label '<xpml></page></xpml><xpml><end/></xpml>';
//         QRTempBlob_lRecTmp: Record "50009" temporary;
//         SRNo_lInt: Integer;
//         R50017_lRpt: Report "50017";
//                          R50018_lRpt: Report "50018";
//     begin
//         QRCodeInput:=STRSUBSTNO('%1',QRCodeInput);
//         CreateQRCode(QRCodeInput,TempBlob);
//     end;

//     local procedure GetQRCode(QRCodeInput: Text) QRCodeFileName: Text
//     var
//         [RunOnClient]
//         IBarCodeProvider: DotNet IBarcodeProvider;
//     begin
//         GetBarCodeProvider(IBarCodeProvider);
//         QRCodeFileName := IBarCodeProvider.GetBarcode(QRCodeInput);
//     end;

//     [Scope('Internal')]
//     procedure UploadFileBLOBImportandDeleteServerFile(var TempBlob: Record "99008535";FileName: Text)
//     var
//         FileManagement: Codeunit "419";
//     begin
//         FileName := FileManagement.UploadFileSilent(FileName);
//         FileManagement.BLOBImportFromServerFile(TempBlob,FileName);
//         DeleteServerFile(FileName);
//     end;

//     [Scope('Internal')]
//     procedure GetBarCodeProvider(var IBarCodeProvider: DotNet IBarcodeProvider)
//     var
//         [RunOnClient]
//         QRCodeProvider: DotNet QRCodeProvider;
//     begin
//         IF ISNULL(IBarCodeProvider) THEN
//           IBarCodeProvider := QRCodeProvider.QRCodeProvider;
//     end;

//     local procedure DeleteServerFile(ServerFileName: Text)
//     begin
//         IF ERASE(ServerFileName) THEN;
//     end;

//     [Scope('Internal')]
//     procedure "---------QrCode--------END"()
//     begin
//     end;

//     [Scope('Internal')]
//     procedure PurchaseCrMemoHeader(DocumentNo: Code[20])
//     begin
//         //RSPL_28117_AviMali_11122020_EINV  <<
//         IF PurchaseCrMemoHeader1.GET(DocumentNo) THEN
//         IsPurchCrMemo := TRUE;
//         //RSPL_28117_AviMali_11122020_EINV  >>
//     end;

//     [Scope('Internal')]
//     procedure GenerateIRNForPurchaseCrMemo_Govt(DocumentNo: Text;AuthToken: Text;Sek: Text;var AckNo: Text;var AckDt: Text;var Irn: Text;var SignedInvoice: Text;var SignedQRCode: Text;Client_ID: Text;Client_Secret: Text;GSTIN: Text;UserName: Text;AddEwbDtls: Boolean;var EwbNo_EwbDate_EwbValidUpto: Text)
//     var
//         Token: Label 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzY29wZSI6WyJnc3AiXSwiZXhwIjoxNTY2ODEzMzUwLCJhdXRob3JpdGllcyI6WyJST0xFX1NCX0VfQVBJX0dTVF9SRVRVUk5TIiwiUk9MRV9TQl9FX0FQSV9FV0IiXSwianRpIjoiYjlhNDUxZWEtNzZkOC00N2U3LTg2ZDktNzJhMTk2MjM2MmNhIiwiY2xpZW50X2lkIjoiRTRCMTcyNDMzNkE5NDI5Q0ExQjM4M0ZEODAzMjBCOEYifQ.1BGkFnecJeY0aaQveGdadj9zU5iRe4qaMJ81HKzKOh8';
//         HttpClient: DotNet HttpClient;
//                         URI: DotNet Uri;
//                         ReqHdr: DotNet HttpRequestHeaders;
//                         HttpStringContent: DotNet StringContent;
//                         txtJsonResult: Text;
//                         HttpResponseMessage: DotNet HttpResponseMessage;
//                         JObject: DotNet JObject;
//                         Encoding: DotNet Encoding;
//                         txtSuccess: Text;
//                         txtJsonResponse: Text;
//                         txtResult: Text;
//                         txtJsonRequest: Text;
//                         TextAppKey: Label 'dN+eAtmvwlz/2rsFe5dXkTps08mMko5Q3uvRsYGIPaT9/BcsfwlR8vnuz47VBRooif2Z9wnCUogApf28IRb91OMPs81U9ON7uvE9qyWFhM+8gBj6kFlwj9oBYfRAiO8Ht8YEqXFs+ZCQkFIu3PsvfKl26w1j8xj1HcaPYeVhchJtvp/zBuo8Uk9fwFDeZRjpJwgnJwLw/wx5O2sydhuUm7srI/FIWZVch2+n9TMRueK4twHm/m7xEQQl3k4kmZTguYa9FmsSRb0HDhtqQsOfz7pB7wm6oVzJR01FKn8fTx2diuZSSy6ycc5o6xM65Vj5EkeDeglAcCXTKYP5jE1b4A==';
//         byteAppKey: DotNet Byte;
//                         ErrorDetails: Text;
//                         ErrorMessage: Text;
//                         ErrorDetailsPos1: Integer;
//                         ErrorDetailsPos2: Integer;
//                         ConvertCode: DotNet Convert;
//                         TempBlob2: Record "99008535" temporary;
//                         TempBlob3: Record "99008535" temporary;
//                         EwbNo: Text;
//                         EwbDt: Text;
//                         EwbValidTill: Text;
//                         RecPurHeader: Record "124";
//                         IRNQRCodeUpdation: Report "50250";
//                         DupIRN: Text;
//                         InfoDtls: Text;
//                         Desc: Text;
//                         InfoDtlsPos1: Integer;
//                         InfoDtlsPos2: Integer;
//                         DescPos1: Integer;
//                         DescPos2: Integer;
//                         ErrorMsg: Label 'Duplicate IRN';
//     begin
//         //RSPL_28117_AviMali_11122020_EINV  <<
//         //CLEARALL;

//         GetServiceProtol;
//         GetAppkey :=  GetAppkey.eInv;
//         byteAppKey  :=  GetAppkey.generateSecureKey();

//         IF RecPurHeader.GET(DocumentNo) THEN
//           txtJsonRequest :=    DynamicJsonReturnForPurchaseCrMemo(DocumentNo,AddEwbDtls);
//         IF  USERID  = 'GPUAE\FAHIM.AHMAD' THEN
//         MESSAGE(txtJsonRequest);

//         txtJsonRequest := GetAppkey.Base64Encode(txtJsonRequest);

//         //MESSAGE(txtJsonRequest);

//         txtJsonRequest := GetAppkey.EncryptBySymmetricKey(txtJsonRequest,Sek);
//         txtJsonRequest  :=  GenerateIRNData1  + txtJsonRequest  + Data2; //DJ Comented

//         //MESSAGE(txtJsonRequest);

//         HttpClient  :=  HttpClient.HttpClient;
//         URI :=  URI.Uri(GenIRNURL);
//         HttpClient.BaseAddress(URI);

//         HttpClient.DefaultRequestHeaders.Add('Client_ID', Client_ID);
//         HttpClient.DefaultRequestHeaders.Add('Client_Secret', Client_Secret);
//         HttpClient.DefaultRequestHeaders.Add('Gstin', GSTIN);
//         HttpClient.DefaultRequestHeaders.Add('user_name', UserName);
//         HttpClient.DefaultRequestHeaders.Add( 'AuthToken', AuthToken);

//         HttpStringContent  :=  HttpStringContent.StringContent(txtJsonRequest,Encoding.UTF8, 'application/json');
//         HttpResponseMessage :=  HttpClient.PostAsync(URI, HttpStringContent).Result;
//         txtJsonResponse :=  HttpResponseMessage.Content.ReadAsStringAsync().Result;

//         IF (USERID = 'ROBOSOFT.SUPPORT2') OR (USERID = 'ROBOSOFT.SUPPORT1') OR (USERID = 'GPUAE\FAHIM.AHMAD') THEN
//           MESSAGE('txtJsonResponse  = ' + txtJsonResponse);

//         JObject :=  JObject.JObject;
//         JObject := JObject.Parse(txtJsonResponse);
//         JObject :=  JObject.GetValue('Status');
//         IF  JObject.ToString  = '0' THEN  BEGIN
//           JObject :=  JObject.JObject;
//           JObject := JObject.Parse(txtJsonResponse);
//           JObject :=  JObject.GetValue('ErrorDetails');

//           ErrorDetails :=  JObject.ToString;
//         //  MESSAGE('ErrorDetails : ' +ErrorDetails);

//           ErrorDetailsPos1  :=  STRPOS(ErrorDetails, '{');
//           ErrorDetailsPos2  :=  STRPOS(ErrorDetails, '}');
//           ErrorDetails  :=  COPYSTR(ErrorDetails, ErrorDetailsPos1+1, ErrorDetailsPos2-1);
//           ErrorDetailsPos2  :=  STRPOS(ErrorDetails, '}');
//           ErrorDetails  :=  '{' + COPYSTR(ErrorDetails, 1, ErrorDetailsPos2-1)  + '}';
//         //  MESSAGE('ErrorDetails123 : ' +ErrorDetails);

//           JObject :=  JObject.JObject;
//           JObject := JObject.Parse(ErrorDetails);
//           JObject :=  JObject.GetValue('ErrorMessage');
//           ErrorMessage  :=  JObject.ToString;


//           //DJ update IRN detail if Duplicate
//           IF ErrorMessage = ErrorMsg THEN BEGIN
//             JObject :=  JObject.JObject;
//             JObject := JObject.Parse(txtJsonResponse);
//             JObject :=  JObject.GetValue('InfoDtls');
//             InfoDtls  :=  JObject.ToString;

//             InfoDtlsPos1  :=  STRPOS(InfoDtls, '{');
//             InfoDtlsPos2  :=  STRPOS(InfoDtls, '}');
//             InfoDtls  :=  COPYSTR(InfoDtls, InfoDtlsPos1+1, InfoDtlsPos2-1);
//             InfoDtlsPos2  :=  STRPOS(InfoDtls, '}');
//             InfoDtls  :=  COPYSTR(InfoDtls, 1, InfoDtlsPos2-1);

//             DescPos1  :=  STRPOS(InfoDtls, '{');
//             DescPos2  :=  STRLEN(InfoDtls);
//             Desc  := '{' + COPYSTR(InfoDtls, DescPos1+1, DescPos2) + '}';

//             JObject :=  JObject.JObject;
//             JObject := JObject.Parse(Desc);
//             JObject :=  JObject.GetValue('Irn');
//             DupIRN  :=  JObject.ToString;

//             IRNQRCodeUpdation.SetDocument(LocVar,DocumentNo,DupIRN);
//             IRNQRCodeUpdation.RUN;
//           END ELSE
//           //DJ update IRN detail if Duplicate
//           ERROR(ErrorMessage)
//         END ELSE  BEGIN
//           JObject :=  JObject.JObject;
//           JObject := JObject.Parse(txtJsonResponse);
//           JObject :=  JObject.GetValue('Data');
//           txtResult  :=  JObject.ToString;

//           txtResult  :=  GetAppkey.DecryptBySymmetricKey(txtResult,ConvertCode.FromBase64String(Sek));
//           txtResult  :=  GetAppkey.Base64Decode(txtResult);


//           JObject :=  JObject.JObject;
//           JObject := JObject.Parse(txtResult);
//           JObject :=  JObject.GetValue('AckNo');
//           AckNo  :=  JObject.ToString;

//           JObject :=  JObject.JObject;
//           JObject := JObject.Parse(txtResult);
//           JObject :=  JObject.GetValue('AckDt');
//           AckDt  :=  JObject.ToString;

//           JObject :=  JObject.JObject;
//           JObject := JObject.Parse(txtResult);
//           JObject :=  JObject.GetValue('Irn');
//           Irn  :=  JObject.ToString;

//           JObject :=  JObject.JObject;
//           JObject := JObject.Parse(txtResult);
//           JObject :=  JObject.GetValue('SignedInvoice');
//           SignedInvoice  :=  JObject.ToString;

//           JObject :=  JObject.JObject;
//           JObject := JObject.Parse(txtResult);
//           JObject :=  JObject.GetValue('SignedQRCode');
//           SignedQRCode  :=  JObject.ToString;

//           JObject :=  JObject.JObject;
//           JObject := JObject.Parse(txtResult);
//           JObject :=  JObject.GetValue('EwbNo');
//           EwbNo  :=  JObject.ToString;

//           JObject :=  JObject.JObject;
//           JObject := JObject.Parse(txtResult);
//           JObject :=  JObject.GetValue('EwbDt');
//           EwbDt  :=  JObject.ToString;

//           JObject :=  JObject.JObject;
//           JObject := JObject.Parse(txtResult);
//           JObject :=  JObject.GetValue('EwbValidTill');
//           EwbValidTill  :=  JObject.ToString;

//           IF EwbNo <>'' THEN
//           EwbNo_EwbDate_EwbValidUpto := EwbNo+','+EwbDt+','+EwbValidTill;

//           MESSAGE('IRN generated successfully')
//         END;

//         //RSPL_28117_AviMali_11122020_EINV  >>
//     end;

//     [Scope('Internal')]
//     procedure DynamicJsonReturnForPurchaseCrMemo(txtDocNo: Text;AddEwbDtls: Boolean) IRNJson: Text
//     var
//         NoSeriesMgt: Codeunit "396";
//         cdNo: Code[20];
//         cdNoSeries: Code[20];
//         Catg: Text;
//         RegRev: Text;
//         Typ: Text;
//         DocType: Text;
//         DocDate: Text;
//         LocRec: Record "14";
//         StateRec: Record "13762";
//         VendorRec: Record "23";
//         StateCd: Integer;
//         StateRec2: Record "13762";
//         AssVal: Decimal;
//         CgstVal: Decimal;
//         SgstVal: Decimal;
//         IgstVal: Decimal;
//         CesVal: Decimal;
//         StCesVal: Decimal;
//         CesNonAdval: Decimal;
//         Disc: Decimal;
//         OthChrg: Decimal;
//         TotInvVal: Decimal;
//         Trsnsdtls: Text;
//         DocDtls: Text;
//         SellerDtls: Text;
//         BuyerDtls: Text;
//         ValDtls: Text;
//         ItemListDtls: Text;
//         DispDtls: Text;
//         ShipDtls: Text;
//         TaxSchema: Text;
//         ItemListValuesDtls: Text;
//         SalesInvoiceLine: Record "113";
//         PurchCrMemoLine: Record "125";
//         AssAmt: Decimal;
//         CgstRt: Decimal;
//         SgstRt: Decimal;
//         IgstRt: Decimal;
//         CesRt: Decimal;
//         CesNonAdval2: Decimal;
//         StateCes: Decimal;
//         FreeQty: Decimal;
//         SNo: Integer;
//         StateRec3: Record "13762";
//         Shiptoadd: Record "222";
//         ValueEntry: Record "5802";
//         ItemLedgerEntry: Record "32";
//         ValueEntryRelation: Record "6508";
//         ItemTrackingManagement: Codeunit "6500";
//         InvoiceRowID: Text[250];
//         BchDtls: Text;
//         TotalSGSTAmt: Decimal;
//         TotalCGSTAmt: Decimal;
//         TotalIGSTAmt: Decimal;
//         ISServc: Text;
//         ShipGSTIN: Text;
//         ShipStcd: Text;
//         ShipPincode: Text;
//         ItemRec: Record "27";
//         recUnitofMeasure: Record "204";
//         qtyUnit: Code[10];
//         ShipToAddress: Record "222";
//         PayDtls: Text;
//         VendorRec2: Record "23";
//         BankAccount: Record "270";
//         Ewbdtls: Text;
//         TranporterRec: Record "50013";
//         ShipMethodRec: Record "10";
//         ExpDtls: Text;
//         RefDtls: Text;
//         AddlDocDtls: Text;
//         VendorLedEntry: Record "25";
//         PaymentDue: Decimal;
//         SellerPhoneNo: Text;
//         SellerEmail: Text;
//         BuyerPhoneNo: Text;
//         BuyerEmail: Text;
//         BuyerGstin: Text[20];
//         BuyerPos: Text[20];
//         BuyerStcd: Text[20];
//         BuyerPincode: Text[20];
//         CurrExchRate: Record "330";
//         TotAmt: Decimal;
//         TotalItemVal: Decimal;
//         HSNRec: Record "16411";
//         GstSetup: Record "16408";
//         GSTRate: Decimal;
//         DiscAmount: Decimal;
//         TDSTCSAmount: Decimal;
//         OrderAddress: Record "224";
//         StateRec4: Record "13762";
//         BuyerAddress1: Text[50];
//         BuyerAddress2: Text[50];
//         BuyerCity: Text[30];
//         BuyerPostCode: Code[20];
//     begin
//         //RSPL_28117_AviMali_11122020_EINV  <<

//         SNo := 0;
//         InitializeVariables;
//         PurchaseCrMemoHeader(txtDocNo);

//         IF IsPurchCrMemo THEN BEGIN
//           DocType := 'DBN';
//           DocDate:=FORMAT(PurchaseCrMemoHeader1."Posting Date",0,'<Day,2>/<Month,2>/<Year4>');
//           IF LocRec.GET(PurchaseCrMemoHeader1."Location Code") THEN;
//           IF StateRec.GET(LocRec."State Code") THEN;
//           VendorRec.GET(PurchaseCrMemoHeader1."Buy-from Vendor No.");
//           VendorRec2.GET(PurchaseCrMemoHeader1."Pay-to Vendor No.");
//           IF ShipMethodRec.GET(PurchaseCrMemoHeader1."Shipment Method Code") THEN;
//           VendorLedEntry.RESET;
//           VendorLedEntry.SETRANGE(VendorLedEntry."Document Type",VendorLedEntry."Document Type"::"Credit Memo");
//           VendorLedEntry.SETRANGE("Document No.",PurchaseCrMemoHeader1."No.");
//           IF VendorLedEntry.FINDFIRST THEN BEGIN
//             VendorLedEntry.CALCFIELDS(VendorLedEntry."Remaining Amt. (LCY)");
//             PaymentDue := VendorLedEntry."Remaining Amt. (LCY)";
//           END;
//           /*
//           IF PurchaseCrMemoHeader1."Ship-to Code" = '' THEN BEGIN
//             IF StateRec2.GET(VendorRec."State Code") THEN;
//           END ELSE BEGIN
//             ShipToAddress.GET(PurchaseCrMemoHeader1."Buy-from Vendor No.",PurchaseCrMemoHeader1."Ship-to Code");
//             IF StateRec2.GET(ShipToAddress.State) THEN;
//           END;
//           */
//           IF PurchaseCrMemoHeader1."Ship-to Code" <> '' THEN BEGIN
//             Shiptoadd.GET(PurchaseCrMemoHeader1."Pay-to Vendor No.",PurchaseCrMemoHeader1."Ship-to Code");
//             IF StateRec3.GET(Shiptoadd.State) THEN;
//             ShipGSTIN := Shiptoadd."GST Registration No.";
//            END ELSE BEGIN
//              //IF StateRec3.GET(PurchaseCrMemoHeader1.State) THEN;
//              IF StateRec3.GET(LocRec."State Code") THEN;
//              ShipGSTIN := VendorRec."GST Registration No."
//            END;

//           IF (PurchaseCrMemoHeader1."GST Vendor Type" = PurchaseCrMemoHeader1."GST Vendor Type"::Registered) THEN BEGIN
//             Catg := 'B2B';
//             RegRev := 'N';
//             IF PurchaseCrMemoHeader1."Order Address Code" <> '' THEN BEGIN
//               OrderAddress.GET(PurchaseCrMemoHeader1."Buy-from Vendor No.",PurchaseCrMemoHeader1."Order Address Code");
//               IF StateRec2.GET(OrderAddress.State) THEN;// DJ 16102020
//               IF StateRec4.GET(VendorRec."State Code")THEN; //AM 26033021
//                 BuyerGstin := OrderAddress."GST Registration No.";
//                 BuyerPos := StateRec2."State Code (GST Reg. No.)";
//                 BuyerStcd := StateRec2."State Code (GST Reg. No.)";
//                 BuyerPincode := OrderAddress."Post Code";
//                 ShipPincode := PurchaseCrMemoHeader1."Ship-to Post Code";
//                 ShipStcd := StateRec3."State Code (GST Reg. No.)";
//                 BuyerAddress1 := OrderAddress.Address;//RSPLSUM26Mar21
//                 BuyerAddress2 := OrderAddress."Address 2";//RSPLSUM26Mar21
//                 BuyerCity := OrderAddress.City;//RSPLSUM26Mar21
//                 BuyerPostCode := OrderAddress."Post Code";//RSPLSUM26Mar21
//                 BuyerPhoneNo := OrderAddress."Phone No.";//RSPLSUM26Mar21
//                 BuyerEmail := OrderAddress."E-Mail";//RSPLSUM26Mar21
//                 IF PurchaseCrMemoHeader1."Ship-to Code" = '' THEN
//                   ShipGSTIN := OrderAddress."GST Registration No."
//                 ELSE
//                   ShipGSTIN := ShipGSTIN;
//               END ELSE BEGIN
//                 BuyerGstin := VendorRec."GST Registration No.";
//                 IF StateRec2.GET(VendorRec."State Code") THEN;
//                 BuyerPos := StateRec2."State Code (GST Reg. No.)";
//                 BuyerStcd := StateRec2."State Code (GST Reg. No.)";
//                 //DJ090621BuyerStcd := StateRec4."State Code (GST Reg. No.)";//RSPLSUM26Mar21
//                 BuyerPincode := VendorRec."Post Code";
//                 ShipPincode := PurchaseCrMemoHeader1."Ship-to Post Code";
//                 //ShipStcd := StateRec3."State Code (GST Reg. No.)";
//                 //ShipStcd := StateRec2."State Code (GST Reg. No.)"
//                 ShipStcd := StateRec3."State Code (GST Reg. No.)";
//                 BuyerAddress1 := VendorRec.Address;//RSPLSUM26Mar21
//                 BuyerAddress2 := VendorRec."Address 2";//RSPLSUM26Mar21
//                 BuyerCity := VendorRec.City;//RSPLSUM26Mar21
//                 BuyerPostCode := VendorRec."Post Code";//RSPLSUM26Mar21
//                 BuyerPhoneNo := VendorRec."Phone No.";//RSPLSUM26Mar21
//                 BuyerEmail := VendorRec."E-Mail";//RSPLSUM26Mar21
//               END;
//           END
//           ELSE IF (PurchaseCrMemoHeader1."GST Vendor Type" = PurchaseCrMemoHeader1."GST Vendor Type"::Unregistered) THEN BEGIN
//             Catg := 'B2B';
//             RegRev := 'N';
//             BuyerGstin := 'URP';
//             ShipGSTIN := 'URP';
//             IF PurchaseCrMemoHeader1."Order Address Code" <> '' THEN BEGIN
//               OrderAddress.GET(PurchaseCrMemoHeader1."Buy-from Vendor No.",PurchaseCrMemoHeader1."Order Address Code");
//               IF StateRec2.GET(OrderAddress.State) THEN;// DJ 16102020
//               IF StateRec4.GET(VendorRec."State Code")THEN;//RSPLSUM26Mar21
//                 BuyerPos := StateRec2."State Code (GST Reg. No.)";
//                 BuyerStcd := StateRec2."State Code (GST Reg. No.)";
//                 BuyerPincode := OrderAddress."Post Code";
//                 ShipPincode := PurchaseCrMemoHeader1."Ship-to Post Code";
//                 ShipStcd := StateRec3."State Code (GST Reg. No.)";
//                 //
//                 BuyerAddress1 := OrderAddress.Address;//RSPLSUM26Mar21
//                 BuyerAddress2 := OrderAddress."Address 2";//RSPLSUM26Mar21
//                 BuyerCity := PurchaseCrMemoHeader1."Ship-to City";//RSPLSUM26Mar21
//                 BuyerPostCode := OrderAddress."Post Code";//RSPLSUM26Mar21
//                 BuyerPhoneNo := OrderAddress."Phone No.";//RSPLSUM26Mar21
//                 BuyerEmail := OrderAddress."E-Mail";//RSPLSUM26Mar21
//                 IF PurchaseCrMemoHeader1."Ship-to Code" = '' THEN
//                   ShipGSTIN := OrderAddress."GST Registration No."
//                 ELSE
//                   ShipGSTIN := ShipGSTIN;
//                 //

//               END ELSE BEGIN
//                 IF StateRec2.GET(VendorRec."State Code") THEN;
//                 BuyerPos := StateRec2."State Code (GST Reg. No.)";
//                 //RSPLSUM26Mar21--BuyerStcd := StateRec2."State Code (GST Reg. No.)";
//                 BuyerStcd := StateRec4."State Code (GST Reg. No.)";//RSPLSUM26Mar21
//                 BuyerPincode := VendorRec."Post Code";
//                 ShipPincode := PurchaseCrMemoHeader1."Ship-to Post Code";
//                 //ShipStcd := StateRec3."State Code (GST Reg. No.)";
//                 ShipStcd := StateRec2."State Code (GST Reg. No.)";
//                 //
//                 ShipStcd := StateRec2."State Code (GST Reg. No.)";
//                 BuyerAddress1 := VendorRec.Address;//RSPLSUM26Mar21
//                 BuyerAddress2 := VendorRec."Address 2";//RSPLSUM26Mar21
//                 BuyerCity := VendorRec.City;//RSPLSUM26Mar21
//                 BuyerPostCode := VendorRec."Post Code";//RSPLSUM26Mar21
//                 BuyerPhoneNo := VendorRec."Phone No.";//RSPLSUM26Mar21
//                 BuyerEmail := VendorRec."E-Mail";//RSPLSUM26Mar21
//                 //

//               END;
//           END
//           ELSE IF PurchaseCrMemoHeader1."GST Vendor Type" = PurchaseCrMemoHeader1."GST Vendor Type"::Import THEN BEGIN
//             Catg := 'EXPWOP';
//             RegRev := 'N';
//             BuyerGstin := 'URP';
//             BuyerPos := '96';
//             BuyerStcd := '96';
//             BuyerPincode := '999999';
//             ShipGSTIN := 'URP';
//             ShipPincode := '999999';
//             ShipStcd := '96';
//            END
//          /* ELSE IF PurchaseCrMemoHeader1."GST Vendor Type" = PurchaseCrMemoHeader1."GST Vendor Type"::"Deemed Export" THEN BEGIN
//             Catg := 'DEXP';
//             RegRev := 'N';
//             BuyerGstin := 'URP';
//             BuyerPos := '96';
//             BuyerStcd := '96';
//             BuyerPincode := '999999';
//             ShipGSTIN := 'URP';
//             ShipPincode := '999999';
//             ShipStcd := '96';
//           END */   //Temp Comment AviMali
//           ELSE IF //(PurchaseCrMemoHeader1."GST Vendor Type" = PurchaseCrMemoHeader1."GST Vendor Type"::"SEZ Development") OR
//                    (PurchaseCrMemoHeader1."GST Vendor Type" = PurchaseCrMemoHeader1."GST Vendor Type"::SEZ) THEN BEGIN
//             Catg := 'SEZWOP';
//             RegRev := 'N';
//             IF PurchaseCrMemoHeader1."Order Address Code" <> '' THEN BEGIN
//               OrderAddress.GET(PurchaseCrMemoHeader1."Buy-from Vendor No.",PurchaseCrMemoHeader1."Order Address Code");
//               IF StateRec2.GET(OrderAddress.State) THEN;// DJ 16102020
//               IF StateRec4.GET(VendorRec."State Code")THEN;//RSPLSUM26Mar21
//                 BuyerGstin := OrderAddress."GST Registration No.";
//                 BuyerAddress1 := OrderAddress.Address;//RSPLSUM26Mar21
//                 BuyerAddress2 := OrderAddress."Address 2";//RSPLSUM26Mar21
//                 BuyerCity := OrderAddress.City;//RSPLSUM26Mar21
//                 BuyerPostCode := OrderAddress."Post Code";//RSPLSUM26Mar21
//                 BuyerPhoneNo := OrderAddress."Phone No.";//RSPLSUM26Mar21
//                 BuyerEmail := OrderAddress."E-Mail";//RSPLSUM26Mar21
//                 BuyerPos := StateRec2."State Code (GST Reg. No.)";
//                 BuyerStcd := StateRec2."State Code (GST Reg. No.)";
//                 BuyerPincode := OrderAddress."Post Code";
//                 ShipPincode := PurchaseCrMemoHeader1."Ship-to Post Code";
//                 ShipStcd := StateRec3."State Code (GST Reg. No.)";
//                 IF PurchaseCrMemoHeader1."Ship-to Code" = '' THEN
//                   ShipGSTIN := OrderAddress."GST Registration No."
//                 ELSE
//                   ShipGSTIN := ShipGSTIN;
//               END ELSE BEGIN
//                 IF StateRec2.GET(VendorRec."State Code") THEN;// DJ 16102020
//                 BuyerGstin := VendorRec."GST Registration No.";
//                 BuyerAddress1 := VendorRec.Address;//RSPLSUM26Mar21
//                 BuyerAddress2 := VendorRec."Address 2";//RSPLSUM26Mar21
//                 BuyerCity := VendorRec.City;//RSPLSUM26Mar21
//                 BuyerPostCode := VendorRec."Post Code";//RSPLSUM26Mar21
//                 BuyerPhoneNo := VendorRec."Phone No.";//RSPLSUM26Mar21
//                 BuyerEmail := VendorRec."E-Mail";//RSPLSUM26Mar21
//                 BuyerPos := StateRec2."State Code (GST Reg. No.)";
//                 //RSPLSUM26Mar21--BuyerStcd := StateRec2."State Code (GST Reg. No.)";
//                 BuyerStcd := StateRec4."State Code (GST Reg. No.)";//RSPLSUM26Mar21
//                 BuyerPincode := VendorRec."Post Code";
//                 ShipPincode := PurchaseCrMemoHeader1."Ship-to Post Code";
//                 ShipStcd := StateRec3."State Code (GST Reg. No.)";
//               END;
//           END;

//         END;

//         TaxSchema := '{'
//         +'  "Version": "1.1",' ;

//         Trsnsdtls := '  "TranDtls": {'
//         +'    "TaxSch": "GST",'
//         +'    "SupTyp": "' + Catg + '"'
//         //+'    "RegRev": "'+ RegRev +'",'
//         //+'    "Typ": "REG",   '
//         //+'    "EcmTrn": "N",'
//         //+'    "EcmGstin": null,'
//         //+'    "IgstOnIntra": "N"'
//         +' },' ;

//         DocDtls := '  "DocDtls": {'
//         +'    "Typ": "'+DocType+'",'
//         +'    "No": "' + txtDocNo + '",'
//         +'    "Dt": "'+ DocDate +'"'
//         +'  },';

//         SellerDtls := '  "SellerDtls": {'
//         +'    "Gstin": "'+LocRec."GST Registration No."+'",'
//         +'    "LglNm": "'+ LocRec.Name +'",'
//         +'    "TrdNm": "'+ LocRec.Name +'",'
//         +'    "Addr1": "'+LocRec.Address+'"';
//         IF LocRec."Address 2" <> '' THEN
//           SellerDtls := SellerDtls + ',' +'    "Addr2": "'+LocRec."Address 2"+'"'
//         ELSE
//           SellerDtls := SellerDtls;
//         SellerDtls := SellerDtls+ ',' +'    "Loc": "'+LocRec.City+'"';

//         IF (LocRec."Post Code" <> '') THEN BEGIN
//           SellerDtls :=SellerDtls + ',' +'    "Pin": '+LocRec."Post Code"+'';
//         END ELSE
//           SellerDtls :=SellerDtls;
//         IF StateRec."State Code (GST Reg. No.)" <> '' THEN BEGIN
//           SellerDtls :=SellerDtls + ',' +'    "Stcd": "'+StateRec."State Code (GST Reg. No.)"+'"';
//         END ELSE
//           SellerDtls :=SellerDtls;

//         IF LocRec."Phone No." <> '' THEN BEGIN
//           SellerPhoneNo := '"Ph": "'+LocRec."Phone No."+'"';
//           SellerDtls :=SellerDtls + ',' + SellerPhoneNo;
//         END ELSE
//           SellerDtls :=SellerDtls;

//         IF LocRec."E-Mail" <> '' THEN BEGIN
//           SellerEmail := 'Em": "'+LocRec."E-Mail"+'"';
//           SellerDtls :=SellerDtls + ',"'+SellerEmail;
//         END ELSE
//           SellerDtls := SellerDtls;
//         SellerDtls := SellerDtls +'  },';

//         BuyerDtls := '  "BuyerDtls": {'
//         +'    "Gstin": "'+ BuyerGstin +'",'
//         +'    "LglNm": "'+ VendorRec.Name +'",'
//         +'    "TrdNm": "'+ VendorRec.Name +'",'
//         +'    "Pos": "'+ BuyerPos +'",'
//         /*
//         +'    "Gstin": "'+ VendorRec."GST Registration No." +'",'
//         +'    "LglNm": "'+ VendorRec.Name +'",'
//         +'    "TrdNm": "'+ VendorRec.Name +'",'
//         +'    "Pos": "'+ StateRec2."State Code (GST Reg. No.)" +'",'
//         */
//         //RSPLSUM26Mar21--+'    "Addr1": "'+ VendorRec.Address +'"';
//         +'    "Addr1": "'+ BuyerAddress1 +'"';//RSPLSUM26Mar21

//         //RSPLSUM26Mar21--IF VendorRec."Address 2" <> '' THEN BEGIN
//           //RSPLSUM26Mar21--BuyerDtls :=BuyerDtls + ',' +'    "Addr2": "'+ VendorRec."Address 2" +'"';
//         IF BuyerAddress2 <> '' THEN BEGIN//RSPLSUM26Mar21
//           BuyerDtls :=BuyerDtls + ',' +'    "Addr2": "'+ BuyerAddress2 +'"';//RSPLSUM26Mar21--
//         END ELSE
//           BuyerDtls :=BuyerDtls;

//         //BuyerDtls :=BuyerDtls + ',' +'    "Loc": "'+LocRec.City+'"';//RSPl AviMali 26032021 Comment
//           //RSPLSUM26Mar21--BuyerDtls :=BuyerDtls + ',' +'    "Loc": "'+VendorRec.City+'"';  //RSPl AviMali 26032021
//           BuyerDtls :=BuyerDtls + ',' +'    "Loc": "'+BuyerCity+'"';//RSPLSUM26Mar21

//         //RSPLSUM26Mar21--IF (VendorRec."Post Code" <> '')  THEN BEGIN
//           //RSPLSUM26Mar21--BuyerDtls :=BuyerDtls + ',' +'    "Pin": '+ VendorRec."Post Code" +'';
//         IF (BuyerPostCode <> '')  THEN BEGIN//RSPLSUM26Mar21
//           BuyerDtls :=BuyerDtls + ',' +'    "Pin": '+ BuyerPostCode +'';//RSPLSUM26Mar21
//         END ELSE
//           BuyerDtls :=BuyerDtls;

//         IF BuyerStcd <> '' THEN BEGIN
//           //RSPLSUM26Mar21--BuyerDtls :=BuyerDtls + ',' +'    "Stcd": "'+ StateRec4."State Code (GST Reg. No.)" +'"'; //Am 26032021
//           BuyerDtls :=BuyerDtls + ',' +'    "Stcd": "'+ BuyerStcd +'"';//RSPLSUM26Mar21
//         END ELSE
//           BuyerDtls :=BuyerDtls;

//         //RSPLSUM26Mar21--IF VendorRec."Phone No." <> '' THEN BEGIN
//           //RSPLSUM26Mar21--BuyerPhoneNo := '"Ph": "'+VendorRec."Phone No."+'"';
//           //RSPLSUM26Mar21--BuyerDtls :=BuyerDtls + ',' + BuyerPhoneNo;
//         IF BuyerPhoneNo <> '' THEN BEGIN//RSPLSUM26Mar21
//           BuyerDtls :=BuyerDtls + ',' + '"Ph": "'+BuyerPhoneNo+'"';//RSPLSUM26Mar21
//         END ELSE
//           BuyerDtls :=BuyerDtls;

//         //RSPLSUM26Mar21--IF VendorRec."E-Mail" <> '' THEN BEGIN
//           //RSPLSUM26Mar21--BuyerEmail := 'Em": "'+VendorRec."E-Mail"+'"';
//           //RSPLSUM26Mar21--BuyerDtls :=BuyerDtls + ',"'+BuyerEmail;
//         IF BuyerEmail <> '' THEN BEGIN//RSPLSUM26Mar21
//           BuyerDtls :=BuyerDtls + ',"'+'Em": "'+BuyerEmail+'"';//RSPLSUM26Mar21
//         END ELSE
//           BuyerDtls:= BuyerDtls;

//         BuyerDtls:= BuyerDtls+'  },';

//         DispDtls := '  "DispDtls": {'
//         +'    "Nm": "'+ LocRec.Name +'",'
//         +'    "Addr1": "'+LocRec.Address+'"';
//         IF LocRec."Address 2" <> '' THEN
//           DispDtls := DispDtls + ',' +'    "Addr2": "'+LocRec."Address 2"+'"'
//         ELSE
//           DispDtls := DispDtls;
//         DispDtls := DispDtls + ',' +'    "Loc": "'+LocRec.City+'",'
//         +'    "Pin": '+LocRec."Post Code"+' ,'
//         +'    "Stcd": "'+StateRec."State Code (GST Reg. No.)"+'"'
//         +'  },';
//         /*
//         IF IsPurchCrMemo THEN BEGIN
//           ShipDtls :=  '"ShipDtls": {'
//           +'    "Gstin": "'+ShipGSTIN+'",'
//           +'    "LglNm": "'+ PurchaseCrMemoHeader1."Ship-to Name" +'",'
//           +'    "TrdNm": "'+ PurchaseCrMemoHeader1."Ship-to Name" +'",'
//           +'    "Addr1": "'+ PurchaseCrMemoHeader1."Ship-to Address" +'"';
//           IF PurchaseCrMemoHeader1."Ship-to Address 2" <> '' THEN
//             ShipDtls := ShipDtls + ',' +'    "Addr2": "'+ PurchaseCrMemoHeader1."Ship-to Address 2" +'"'
//           ELSE
//             ShipDtls := ShipDtls;
//           ShipDtls := ShipDtls + ',' +'    "Loc": "'+PurchaseCrMemoHeader1."Ship-to City"+'"';

//         IF (ShipPincode <> '') THEN BEGIN
//           ShipDtls := ShipDtls + ',' +'    "Pin": '+ ShipPincode +'';
//         END ELSE
//           ShipDtls := ShipDtls;

//         IF ShipStcd <> '' THEN BEGIN
//           ShipDtls := ShipDtls + ',' +'    "Stcd": "'+ ShipStcd +'"';
//         END ELSE
//           ShipDtls := ShipDtls;
//         ShipDtls := ShipDtls  +'  },';

//         END;*/
//         IF IsPurchCrMemo THEN BEGIN
//           ShipDtls :=  '"ShipDtls": {'
//           +'    "Gstin": "'+ShipGSTIN+'",'
//           +'    "LglNm": "'+ PurchaseCrMemoHeader1."Ship-to Name" +'",'
//           +'    "TrdNm": "'+ PurchaseCrMemoHeader1."Ship-to Name" +'",'
//           //RSPLSUM26Mar21--+'    "Addr1": "'+ OrderAddress.Address +'"';
//           +'    "Addr1": "'+ BuyerAddress1 +'"';//RSPLSUM26Mar21

//           //RSPLSUM26Mar21--IF OrderAddress."Address 2" <> '' THEN
//             //RSPLSUM26Mar21--ShipDtls := ShipDtls + ',' +'    "Addr2": "'+ OrderAddress."Address 2" +'"'
//           IF BuyerAddress2 <> '' THEN//RSPLSUM26Mar21
//             ShipDtls := ShipDtls + ',' +'    "Addr2": "'+ BuyerAddress2 +'"'//RSPLSUM26Mar21
//           ELSE
//             ShipDtls := ShipDtls;

//           //RSPLSUM26Mar21--ShipDtls := ShipDtls + ',' +'    "Loc": "'+OrderAddress.City+'"';
//           ShipDtls := ShipDtls + ',' +'    "Loc": "'+BuyerCity+'"';//RSPLSUM26Mar21

//         //RSPLSUM26Mar21--IF (ShipPincode <> '') THEN BEGIN
//           //RSPLSUM26Mar21--ShipDtls := ShipDtls + ',' +'    "Pin": '+ OrderAddress."Post Code" +'';
//         IF (BuyerPostCode <> '') THEN BEGIN//RSPLSUM26Mar21
//           ShipDtls := ShipDtls + ',' +'    "Pin": '+ BuyerPostCode +'';//RSPLSUM26Mar21
//         END ELSE
//           ShipDtls := ShipDtls;

//         //RSPLSUM26Mar21--IF ShipStcd <> '' THEN BEGIN
//           //RSPLSUM26Mar21--ShipDtls := ShipDtls + ',' +'    "Stcd": "'+ ShipStcd +'"';
//         IF BuyerStcd <> '' THEN BEGIN//RSPLSUM26Mar21
//           ShipDtls := ShipDtls + ',' +'    "Stcd": "'+ BuyerStcd +'"';//RSPLSUM26Mar21
//         END ELSE
//           ShipDtls := ShipDtls;

//         ShipDtls := ShipDtls  +'  },';

//         END;

//         //
//          /* IF IsPurchCrMemo THEN BEGIN
//           ShipDtls :=  '"ShipDtls": {'
//           +'    "Gstin": "'+ShipGSTIN+'",'
//           +'    "LglNm": "'+ PurchaseCrMemoHeader1."Ship-to Name" +'",'
//           +'    "TrdNm": "'+ PurchaseCrMemoHeader1."Ship-to Name" +'"';
//          IF PurchaseCrMemoHeader1."Order Address Code" <>'' THEN BEGIN
//           IF OrderAddress.GET(PurchaseCrMemoHeader1."Order Address Code") THEN;
//              ShipDtls := ShipDtls + ',' +'    "Addr1": "'+ OrderAddress.Address+'"'
//          END  ELSE
//             ShipDtls := ShipDtls + ',' +'    "Addr1": "'+ VendorRec.Address+'"';

//           IF OrderAddress."Address 2" <> '' THEN BEGIN
//             ShipDtls := ShipDtls + ',' +'    "Addr2": "'+ OrderAddress."Address 2" +'"'
//           END ELSE
//             ShipDtls := ShipDtls + ',' +'    "Addr2": "'+ VendorRec."Address 2" + '"';

//           IF OrderAddress.City <>'' THEN BEGIN
//               ShipDtls := ShipDtls + ',' +'    "Loc": "'+OrderAddress.City+'"'
//           END ELSE
//               ShipDtls := ShipDtls + ',' +'    "Loc": "'+VendorRec.City+'"';

//           IF OrderAddress."Post Code" <> '' THEN BEGIN
//             ShipDtls := ShipDtls + ',' +'    "Pin": "'+ OrderAddress."Post Code"+'"'
//           END ELSE
//             ShipDtls := ShipDtls + ',' +'    "Pin": "'+ VendorRec."Post Code"+'"';

//             IF OrderAddress.State <> '' THEN BEGIN
//               IF StateRec4.GET(OrderAddress.State) THEN;
//                ShipDtls := ShipDtls + ',' +'    "Stcd": "'+ StateRec4."State Code (GST Reg. No.)" +'"'
//             END ELSE IF VendorRec."State Code" <>'' THEN BEGIN
//                 IF StateRec4.GET(VendorRec."State Code") THEN;
//                   ShipDtls := ShipDtls + ',' +'    "Stcd": "'+ StateRec4."State Code (GST Reg. No.)" +'"';
//             END;

//              ShipDtls:= ShipDtls+'  },';
//         END;
//         */

//         //

//         ItemListDtls := ItemListDtls +'"ItemList": [';

//         IF IsPurchCrMemo THEN BEGIN
//           PurchCrMemoLine.SETRANGE("Document No.",txtDocNo);
//           PurchCrMemoLine.SETFILTER("No.",'<>%1','');
//           PurchCrMemoLine.SETFILTER(Quantity,'<>%1',0);
//           PurchCrMemoLine.SETFILTER(Amount,'>%1',0);
//           IF PurchCrMemoLine.FIND('-') THEN BEGIN
//             IF PurchCrMemoLine.COUNT > 100 THEN
//               ERROR(SalesLinesErr,PurchCrMemoLine.COUNT);
//             REPEAT
//               IF (PurchCrMemoLine."No." <> '74012210')  THEN BEGIN
//               //AND (PurchCrMemoLine."No." <> '12982710')
//               BchDtls := '';
//               SNo += 1;

//             AssAmt := ROUND(
//               CurrExchRate.ExchangeAmtFCYToLCY(
//                 WORKDATE,PurchaseCrMemoHeader1."Currency Code",PurchCrMemoLine."GST Base Amount",PurchaseCrMemoHeader1."Currency Factor"),0.01,'=');
//             TotAmt := ROUND(
//               CurrExchRate.ExchangeAmtFCYToLCY(
//                 WORKDATE,PurchaseCrMemoHeader1."Currency Code",PurchCrMemoLine."Line Amount",PurchaseCrMemoHeader1."Currency Factor"),0.01,'=');
//             TotalItemVal := ROUND(
//               CurrExchRate.ExchangeAmtFCYToLCY(
//                 WORKDATE,PurchaseCrMemoHeader1."Currency Code",(PurchCrMemoLine."Amount To Vendor"),PurchaseCrMemoHeader1."Currency Factor"),0.01,'=');
//             DiscAmount := ROUND(
//               CurrExchRate.ExchangeAmtFCYToLCY(
//                 WORKDATE,PurchaseCrMemoHeader1."Currency Code",(PurchCrMemoLine."Line Discount Amount"),PurchaseCrMemoHeader1."Currency Factor"),0.01,'=');
//             // TDSTCSAmount := ROUND(                 Temp Comment AviMali
//               // CurrExchRate.ExchangeAmtFCYToLCY(
//                 // WORKDATE,PurchaseCrMemoHeader1."Currency Code",(PurchCrMemoLine."TDS/TCS Amount"),PurchaseCrMemoHeader1."Currency Factor"),0.01,'=');
//             //TDSTCSAmount := 144.26;
//             /* IF PurchCrMemoLine."Free Supply" THEN
//                 FreeQty := PurchCrMemoLine.Quantity
//               ELSE
//                 FreeQty := 0;   *///AviMali Temp Comment
//               GetGSTCompRate(PurchCrMemoLine."Document No.",PurchCrMemoLine."Line No.",
//                 CgstRt,SgstRt,IgstRt,CesRt,CesNonAdval,StateCes);

//               IF HSNRec.GET(PurchCrMemoLine."GST Group Code",PurchCrMemoLine."HSN/SAC Code") THEN BEGIN
//                 IF HSNRec.Type = HSNRec.Type::HSN THEN
//                   ISServc := 'N'
//                 ELSE
//                   ISServc := 'Y'
//               END;

//               GstSetup.RESET;
//               GstSetup.SETRANGE("GST Group Code",PurchCrMemoLine."GST Group Code");
//               GstSetup.SETRANGE("GST Jurisdiction Type",GstSetup."GST Jurisdiction Type"::Interstate);
//               IF GstSetup.FINDFIRST THEN
//                 GSTRate := GstSetup."GST Component %";

//               ItemListDtls += '{'
//               +'      "SlNo": "'+FORMAT(SNo)+'",'
//               +'      "IsServc": "'+ISServc+'",'
//               +'      "PrdDesc": "'+PurchCrMemoLine.Description+'",'
//               +'      "HsnCd": "'+PurchCrMemoLine."HSN/SAC Code"+'",';
//               InvoiceRowID := ItemTrackingManagement.ComposeRowID(DATABASE::"Purch. Cr. Memo Hdr.",0,txtDocNo,'',0,PurchCrMemoLine."Line No.");
//               ValueEntryRelation.SETCURRENTKEY("Source RowId");
//               ValueEntryRelation.SETRANGE("Source RowId",InvoiceRowID);
//               IF ValueEntryRelation.FINDSET THEN BEGIN
//                 REPEAT
//                   ValueEntry.GET(ValueEntryRelation."Value Entry No.");
//                   ItemLedgerEntry.GET(ValueEntry."Item Ledger Entry No.");
//                     BchDtls +=' "BchDtls": {'
//                      +'      "Nm": "'+COPYSTR(ItemLedgerEntry."Lot No." + ItemLedgerEntry."Serial No.",1,20)+'"'
//                      //+'      "ExpDt": "'+FORMAT(TODAY,0,'<Day,2>/<Month,2>/<Year4>')+'",'
//                      //+'      "WrDt": "'+FORMAT(TODAY,0,'<Day,2>/<Month,2>/<Year4>')+'"'
//                      // +'      "ExpDt": "'+FORMAT(ItemLedgerEntry."Expiration Date",0,'<Day,2>/<Month,2>/<Year4>')+'",'
//                       //+'      "WrDt": "'+FORMAT(ItemLedgerEntry."Warranty Date",0,'<Day,2>/<Month,2>/<Year4>')+'"'
//                      +'  },';
//                 UNTIL ValueEntryRelation.NEXT = 0;
//               END;
//                 IF ItemRec.GET(PurchCrMemoLine."No.") THEN;
//                 IF recUnitofMeasure.GET(PurchCrMemoLine."Unit of Measure Code")  THEN
//                   qtyUnit := recUnitofMeasure."GST Reporting UQC";
//                 IF (PurchCrMemoLine.Type = PurchCrMemoLine.Type::"G/L Account") AND (PurchCrMemoLine."Unit of Measure Code"= '') THEN
//                   qtyUnit := 'NOS';
//                 GetGSTValForPurchCrMemo(AssVal,CgstVal,SgstVal,IgstVal,CesVal,StCesVal,CesNonAdval,Disc,OthChrg,TotInvVal,txtDocNo,PurchCrMemoLine."Line No.");
//                 ItemListDtls := ItemListDtls + BchDtls;
//                 ItemListDtls += '"Qty": '+DELCHR(FORMAT(PurchCrMemoLine.Quantity), '=',',')+','
//                 +'      "Unit": "'+qtyUnit+'",'
//                 +'      "UnitPrice": '+DELCHR(FORMAT(ROUND((PurchCrMemoLine."Unit Cost"),0.01,'=')), '=',',')+','  //Replce Unit Price To Unit Cost AviMali
//                 +'      "TotAmt": '+DELCHR(FORMAT(ROUND((TotAmt+OthChrg+DiscAmount),0.01,'=')), '=',',')+','
//                 +'      "Discount":'+DELCHR(FORMAT(DiscAmount), '=',',')+','
//                 +'      "AssAmt":'+DELCHR(FORMAT(AssAmt), '=',',')+','
//                 +'      "GstRt": '+DELCHR(FORMAT(GSTRate), '=',',')+','
//                 +'      "SgstAmt": '+DELCHR(FORMAT(SgstVal), '=',',')+','
//                 +'      "IgstAmt": '+DELCHR(FORMAT(IgstVal), '=',',')+','
//                 +'      "CgstAmt": '+DELCHR(FORMAT(CgstVal), '=',',')+','
//                 +'      "CesRt": '+DELCHR(FORMAT(CesRt), '=',',')+','
//                 +'      "CesAmt": '+DELCHR(FORMAT(CesVal), '=',',')+','
//                 +'      "CesNonAdvlAmt": '+DELCHR(FORMAT(CesNonAdval), '=',',')+','
//                 +'      "StateCesRt": '+DELCHR(FORMAT(StateCes), '=',',')+','
//                 +'      "StateCesAmt": '+DELCHR(FORMAT(StCesVal), '=',',')+','
//                 +'      "StateCesNonAdvlAmt": '+DELCHR(FORMAT(0), '=',',')+','
//                 +'      "OthChrg": '+DELCHR(FORMAT(TDSTCSAmount), '=',',')+','
//                 +'      "TotItemVal": '+DELCHR(FORMAT(TotalItemVal), '=',',')+''
//                 +'    },' ;
//                 TotalSGSTAmt +=SgstVal;
//                 TotalIGSTAmt +=IgstVal;
//                 TotalCGSTAmt +=CgstVal;
//                 CesVal +=CesNonAdval;
//                END;
//               UNTIL PurchCrMemoLine.NEXT = 0;
//               ItemListDtls  :=  COPYSTR(ItemListDtls, 1,  STRLEN(ItemListDtls)-1);
//               ItemListDtls +=  '],';
//             END;
//          END;

//          ValDtls := '"ValDtls": {'
//          +'    "AssVal": '+DELCHR(FORMAT(AssVal), '=',',')+','
//          +'    "SgstVal": '+DELCHR(FORMAT(TotalSGSTAmt), '=',',')+','
//          +'    "CgstVal": '+DELCHR(FORMAT(TotalCGSTAmt), '=',',')+','
//          +'    "IgstVal": '+DELCHR(FORMAT(TotalIGSTAmt), '=',',')+','
//          +'    "CesVal": '+DELCHR(FORMAT(CesVal), '=',',')+','
//          +'    "StCesVal": '+DELCHR(FORMAT(StCesVal), '=',',')+','
//          +'    "RndOffAmt": null,'
//          +'    "TotInvVal": '+DELCHR(FORMAT(TotInvVal), '=',',')+''
//          +'}';


//         PayDtls := ',"PayDtls": {'
//         +'    "Nm": "'+VendorRec.Name+'",'
//         //+'    "AccDet": "'+BankAccount."Bank Account No."+'",'
//         +'    "AccDet": "'+AccDet+'",'
//         +'    "Mode": "'+PurchaseCrMemoHeader1."Payment Method Code"+'",'
//         //+'    "FinInsbr": "'+SalesInvoiceHeader."Bank Account"+'",'
//         +'    "FinInsbr": "'+FinInsbr+'",'
//         +'    "PayTerm": "'+PurchaseCrMemoHeader1."Payment Terms Code"+'",'
//         +'    "PayInstr": "'+PayInstr+'",'
//         +'    "CrTrn": "'+CrTrn+'",'
//         +'    "DirDr": "'+DirDr+'",'
//         +'    "CrDay": '+CrDay+','
//         +'    "PaidAmt": '+PaidAmt+','
//         +'    "PaymtDue": '+DELCHR(FORMAT(PaymentDue), '=',',')+''
//         +'    },';


//         RefDtls := '"RefDtls": {'
//         +'  "InvRm": null,'
//         +'    "DocPerdDtls": {'
//         //+'  "InvStDt": "'+InvStDt+'",'
//         //+'  "InvEndDt": "'+InvEndDt+'"'
//         +'  "InvStDt": "'+FORMAT(TODAY,0,'<Day,2>/<Month,2>/<Year4>')+'",'
//         +'  "InvEndDt": "'+FORMAT(TODAY,0,'<Day,2>/<Month,2>/<Year4>')+'"'

//         +'    },'
//         +'    "PrecDocDtls": ['
//         +'      {'
//               +'  "InvNo": "'+InvNo+'",'
//               //+'  "InvDt": "'+InvDt+'",'
//               +'  "InvDt": "'+FORMAT(TODAY,0,'<Day,2>/<Month,2>/<Year4>')+'",'
//               +'  "OthRefNo": "'+OthRefNo+'"'
//         +'      }'
//         +'    ],'
//         +'    "ContrDtls": ['
//         +'      {'
//                 +'  "RecAdvRefr": "'+RecAdvRefr+'",'
//                // +'  "RecAdvDt": "'+RecAdvDt+'",'
//                 +'  "RecAdvDt": "'+FORMAT(TODAY,0,'<Day,2>/<Month,2>/<Year4>')+'",'
//                 +'  "TendRefr": "'+TendRefr+'",'
//                 +'  "ContrRefr": "'+ContrRefr+'",'
//                 +'  "ExtRefr": "'+ExtRefr+'",'
//                 +'  "ProjRefr": "'+ProjRefr+'",'
//                 +'  "PORefr": "'+PurchaseCrMemoHeader1."Vendor Cr. Memo No."+'",'
//                // +'  "PORefDt": "'+PORefDt+'"'
//                +'  "PORefDt": "'+FORMAT(TODAY,0,'<Day,2>/<Month,2>/<Year4>')+'"'
//         +'      }'
//         +'    ]'
//         +'  },';
//         AddlDocDtls := '"AddlDocDtls": ['
//         +'   {'
//         +'     "Url": "'+Url+'",'
//         +'     "Docs": "'+Docs+'",'
//         +'     "Info": "'+Info+'"'
//         +'   }'
//         +' ]';


//         IF IsPurchCrMemo THEN  BEGIN
//           IF PurchaseCrMemoHeader1."GST Vendor Type" = PurchaseCrMemoHeader1."GST Vendor Type"::Import THEN BEGIN
//             ExpDtls := ',"ExpDtls": {'
//             +'  "ShipBNo": "'+PurchaseCrMemoHeader1."Bill of Entry No."+'",'
//             +'  "ShipBDt": "'+FORMAT(PurchaseCrMemoHeader1."Bill of Entry Date",0,'<Day,2>/<Month,2>/<Year4>')+'"';
//            // +'  "Port": '+SalesCrMemoHeader."Exit Point"+','
//         //  +'  "RefClm": "'+SalesCrMemoHeader."LR/RR No."+'",'
//              IF PurchaseCrMemoHeader1."Currency Code" <> '' THEN
//                ExpDtls := ExpDtls + ',' +'   "ForCur": "'+PurchaseCrMemoHeader1."Currency Code"+'"'
//              ELSE
//                ExpDtls := ExpDtls;
//              ExpDtls := ExpDtls +',' +'  "CntCode": "'+SalesCrMemoHeader."Sell-to Country/Region Code"+'",'
//              +'  "ExpDuty": '+'null'+''
//              +'  }';
//            END;
//         END;

//         Ewbdtls := '}';

//         IRNJson := TaxSchema + Trsnsdtls + DocDtls + SellerDtls + BuyerDtls +DispDtls + ShipDtls + ItemListDtls + ValDtls + PayDtls + RefDtls + AddlDocDtls + ExpDtls + Ewbdtls;

//         //RSPL_28117_AviMali_11122020_EINV   >>

//     end;

//     local procedure GetGSTValForPurchCrMemo(var AssVal: Decimal;var CgstVal: Decimal;var SgstVal: Decimal;var IgstVal: Decimal;var CesVal: Decimal;var StCesVal: Decimal;var CesNonAdval: Decimal;var Disc: Decimal;var OthChrg: Decimal;var TotInvVal: Decimal;DocumentNo: Code[20];LineNo: Integer)
//     var
//         PurchCrMemoLine: Record "125";
//         GSTLedgerEntry: Record "16418";
//         DetailedGSTLedgerEntry: Record "16419";
//         CurrExchRate: Record "330";
//         CustLedgerEntry: Record "21";
//         GSTComponent: Record "16405";
//         TotGSTAmt: Decimal;
//         PosStrOrderLine: Record "13798";
//     begin
//         //RSPL_28117_AviMali_11122020_EINV  <<
//         OthChrg := 0;
//         CgstVal := 0;
//         SgstVal := 0;
//         IgstVal := 0;
//         DetailedGSTLedgerEntry.SETRANGE("Document No.",DocumentNo);
//         DetailedGSTLedgerEntry.SETRANGE("Document Line No.",LineNo);
//         DetailedGSTLedgerEntry.SETRANGE("GST Component Code",'CGST');
//         IF DetailedGSTLedgerEntry.FINDSET THEN BEGIN
//           REPEAT
//             CgstVal += ABS(DetailedGSTLedgerEntry."GST Amount");
//           UNTIL DetailedGSTLedgerEntry.NEXT = 0;
//         END ELSE
//           CgstVal := 0;

//         DetailedGSTLedgerEntry.SETFILTER("GST Component Code",'%1|%2','SGST','UTGST');
//         IF DetailedGSTLedgerEntry.FINDSET THEN BEGIN
//           REPEAT
//             SgstVal += ABS(DetailedGSTLedgerEntry."GST Amount")
//           UNTIL DetailedGSTLedgerEntry.NEXT = 0;
//         END ELSE
//           SgstVal := 0;

//         DetailedGSTLedgerEntry.SETRANGE("GST Component Code",'IGST');
//         IF DetailedGSTLedgerEntry.FINDSET THEN BEGIN
//           REPEAT
//             IgstVal += ABS(DetailedGSTLedgerEntry."GST Amount")
//           UNTIL DetailedGSTLedgerEntry.NEXT = 0;
//         END ELSE
//           IgstVal := 0;

//         CesVal := 0;
//         CesNonAdval := 0;
//         IF IsPurchCrMemo THEN BEGIN
//           PurchCrMemoLine.SETRANGE("Document No.",DocumentNo);
//           PurchCrMemoLine.SETRANGE("Line No.",LineNo);
//           IF PurchCrMemoLine.FINDSET THEN BEGIN
//             REPEAT
//               AssVal += ROUND(
//                   CurrExchRate.ExchangeAmtFCYToLCY(
//                     WORKDATE,PurchaseCrMemoHeader1."Currency Code",PurchCrMemoLine."GST Base Amount",PurchaseCrMemoHeader1."Currency Factor"),0.01,'=');
//               TotGSTAmt += ROUND(
//                   CurrExchRate.ExchangeAmtFCYToLCY(
//                     WORKDATE,PurchaseCrMemoHeader1."Currency Code",PurchCrMemoLine."Total GST Amount",PurchaseCrMemoHeader1."Currency Factor"),0.01,'=');
//               Disc += ROUND(
//                   CurrExchRate.ExchangeAmtFCYToLCY(
//                     WORKDATE,PurchaseCrMemoHeader1."Currency Code",PurchCrMemoLine."Inv. Discount Amount",PurchaseCrMemoHeader1."Currency Factor"),0.01,'=');
//               TotInvVal += ROUND(
//                  CurrExchRate.ExchangeAmtFCYToLCY(
//                    WORKDATE,PurchaseCrMemoHeader1."Currency Code",PurchCrMemoLine."Amount To Vendor",PurchaseCrMemoHeader1."Currency Factor"),0.01,'=');
//             UNTIL PurchCrMemoLine.NEXT = 0;
//           END;

//             PosStrOrderLine.RESET;
//             PosStrOrderLine.SETRANGE(Type,PosStrOrderLine.Type::Sale);
//             PosStrOrderLine.SETRANGE("Document Type",PosStrOrderLine."Document Type"::Invoice);
//             PosStrOrderLine.SETRANGE("Tax/Charge Type",PosStrOrderLine."Tax/Charge Type"::Charges);
//             PosStrOrderLine.SETFILTER("Tax/Charge Group",'<>%1','CESS');//DJ 25112020 INV-I/20/CL/2021/518
//             PosStrOrderLine.SETRANGE("Invoice No.",DocumentNo);
//             PosStrOrderLine.SETRANGE("Line No.",LineNo);
//             IF PosStrOrderLine.FINDFIRST THEN
//               REPEAT
//                 OthChrg += PosStrOrderLine."Amount (LCY)";
//               UNTIL PosStrOrderLine.NEXT= 0;

//             PosStrOrderLine.RESET;
//             PosStrOrderLine.SETRANGE(Type,PosStrOrderLine.Type::Sale);
//             PosStrOrderLine.SETRANGE("Document Type",PosStrOrderLine."Document Type"::Invoice);
//             PosStrOrderLine.SETFILTER("Tax/Charge Group",'=%1','CESS');//DJ 25112020 INV-I/20/CL/2021/518
//             ////DJ 25112020 INV-I/20/CL/2021/518 PosStrOrderLine.SETRANGE("Tax/Charge Type",PosStrOrderLine."Tax/Charge Type"::"Other Taxes");
//             PosStrOrderLine.SETRANGE("Invoice No.",DocumentNo);
//             PosStrOrderLine.SETRANGE("Line No.",LineNo);
//             IF PosStrOrderLine.FINDFIRST THEN
//               REPEAT
//                 CesNonAdval += PosStrOrderLine."Amount (LCY)";
//               UNTIL PosStrOrderLine.NEXT= 0;

//         END;
//         //RSPL_28117_AviMali_11122020_EINV  >>
//     end;

//     [Scope('Internal')]
//     procedure GetToken(AppID: Text;AppSecret: Text;var AuthToken: Text[1000];var TokenExpiry: Text)
//     var
//         Token: Label 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzY29wZSI6WyJnc3AiXSwiZXhwIjoxNTY2ODEzMzUwLCJhdXRob3JpdGllcyI6WyJST0xFX1NCX0VfQVBJX0dTVF9SRVRVUk5TIiwiUk9MRV9TQl9FX0FQSV9FV0IiXSwianRpIjoiYjlhNDUxZWEtNzZkOC00N2U3LTg2ZDktNzJhMTk2MjM2MmNhIiwiY2xpZW50X2lkIjoiRTRCMTcyNDMzNkE5NDI5Q0ExQjM4M0ZEODAzMjBCOEYifQ.1BGkFnecJeY0aaQveGdadj9zU5iRe4qaMJ81HKzKOh8';
//         HttpClient: DotNet HttpClient;
//                         URI: DotNet Uri;
//                         ReqHdr: DotNet HttpRequestHeaders;
//                         HttpStringContent: DotNet StringContent;
//                         txtJsonResult: Text;
//                         Encoding: DotNet Encoding;
//                         HttpResponseMessage: DotNet HttpResponseMessage;
//                         txtSuccess: Text;
//                         txtJsonResponse: Text;
//                         txtResult: Text;
//                         txtJsonRequest: Text;
//                         TextAppKey: Label 'dN+eAtmvwlz/2rsFe5dXkTps08mMko5Q3uvRsYGIPaT9/BcsfwlR8vnuz47VBRooif2Z9wnCUogApf28IRb91OMPs81U9ON7uvE9qyWFhM+8gBj6kFlwj9oBYfRAiO8Ht8YEqXFs+ZCQkFIu3PsvfKl26w1j8xj1HcaPYeVhchJtvp/zBuo8Uk9fwFDeZRjpJwgnJwLw/wx5O2sydhuUm7srI/FIWZVch2+n9TMRueK4twHm/m7xEQQl3k4kmZTguYa9FmsSRb0HDhtqQsOfz7pB7wm6oVzJR01FKn8fTx2diuZSSy6ycc5o6xM65Vj5EkeDeglAcCXTKYP5jE1b4A==';
//         byteAppKey: DotNet Byte;
//                         recGeneralLedgerSetup: Record "98";
//                         decMinutes: Decimal;
//                         intYear: Integer;
//                         intMonth: Integer;
//                         intDay: Integer;
//                         dtTokenExpiry: DateTime;
//                         txtTime: Text;
//                         tTime: Time;
//                         txtYear: Text;
//                         txtMonth: Text;
//                         txtDay: Text;
//                         AppKey: Text;
//                         LocRec: Record "14";
//                         JObject: DotNet JObject;
//                         varDurationmillisecond: Duration;
//                         decsecond: Decimal;
//                         MyOutStream: OutStream;
//                         MyInStream: InStream;
//     begin
//         LocRec.GET(LocVar);
//         IF CURRENTDATETIME > LocRec."E-Inv Token Expiry" THEN BEGIN
//           GetServiceProtol;
//           HttpClient  :=  HttpClient.HttpClient;
//           URI :=  URI.Uri(GetTokenURL);
//           HttpClient.BaseAddress(URI);
//           HttpClient.DefaultRequestHeaders.Add('gspappid', AppID);
//           HttpClient.DefaultRequestHeaders.Add('gspappsecret', AppSecret);
//           HttpStringContent  :=  HttpStringContent.StringContent(txtJsonRequest,Encoding.UTF8, 'application/json');
//           HttpResponseMessage :=  HttpClient.PostAsync(URI, HttpStringContent).Result;
//           txtJsonResponse :=  HttpResponseMessage.Content.ReadAsStringAsync().Result;

//             JObject :=  JObject.JObject;
//             JObject := JObject.Parse(txtJsonResponse);
//             JObject :=  JObject.GetValue('access_token');
//             AuthToken  :=  JObject.ToString;

//             JObject :=  JObject.JObject;
//             JObject := JObject.Parse(txtJsonResponse);
//             JObject :=  JObject.GetValue('expires_in');
//             TokenExpiry  :=  JObject.ToString;

//             EVALUATE(decsecond, TokenExpiry);
//             varDurationmillisecond := ((decsecond * 1000) DIV 1);
//             dtTokenExpiry := CURRENTDATETIME + varDurationmillisecond;

//             LocRec."GSP E-Inv Token".CREATEOUTSTREAM(MyOutStream);
//             MyOutStream.WRITETEXT(AuthToken);
//             LocRec."E-Inv Token Expiry"  :=  dtTokenExpiry;
//             LocRec.MODIFY;
//         END;

//         IF AuthToken = '' THEN BEGIN
//           LocRec.CALCFIELDS("GSP E-Inv Token");
//           IF LocRec."GSP E-Inv Token".HASVALUE THEN BEGIN
//             LocRec."GSP E-Inv Token".CREATEINSTREAM(MyInStream);
//             MyInStream.READTEXT(AuthToken);
//           END;
//         END;
//     end;

//     [Scope('Internal')]
//     procedure GenerateIRN(DocumentNo: Text;AuthToken: Text;var AckNo: Text;var AckDt: Text;var Irn: Text;var SignedInvoice: Text;var SignedQRCode: Text;Password: Text;GSTIN: Text;UserName: Text;AddEwbDtls: Boolean;var EwbNo_EwbDate_EwbValidUpto: Text)
//     var
//         Token: Label 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzY29wZSI6WyJnc3AiXSwiZXhwIjoxNTY2ODEzMzUwLCJhdXRob3JpdGllcyI6WyJST0xFX1NCX0VfQVBJX0dTVF9SRVRVUk5TIiwiUk9MRV9TQl9FX0FQSV9FV0IiXSwianRpIjoiYjlhNDUxZWEtNzZkOC00N2U3LTg2ZDktNzJhMTk2MjM2MmNhIiwiY2xpZW50X2lkIjoiRTRCMTcyNDMzNkE5NDI5Q0ExQjM4M0ZEODAzMjBCOEYifQ.1BGkFnecJeY0aaQveGdadj9zU5iRe4qaMJ81HKzKOh8';
//         HttpClient: DotNet HttpClient;
//                         URI: DotNet Uri;
//                         ReqHdr: DotNet HttpRequestHeaders;
//                         HttpStringContent: DotNet StringContent;
//                         txtJsonResult: Text;
//                         HttpResponseMessage: DotNet HttpResponseMessage;
//                         JObject: DotNet JObject;
//                         Encoding: DotNet Encoding;
//                         txtSuccess: Text;
//                         txtJsonResponse: Text;
//                         txtResult: Text;
//                         txtJsonRequest: Text;
//                         TextAppKey: Label 'dN+eAtmvwlz/2rsFe5dXkTps08mMko5Q3uvRsYGIPaT9/BcsfwlR8vnuz47VBRooif2Z9wnCUogApf28IRb91OMPs81U9ON7uvE9qyWFhM+8gBj6kFlwj9oBYfRAiO8Ht8YEqXFs+ZCQkFIu3PsvfKl26w1j8xj1HcaPYeVhchJtvp/zBuo8Uk9fwFDeZRjpJwgnJwLw/wx5O2sydhuUm7srI/FIWZVch2+n9TMRueK4twHm/m7xEQQl3k4kmZTguYa9FmsSRb0HDhtqQsOfz7pB7wm6oVzJR01FKn8fTx2diuZSSy6ycc5o6xM65Vj5EkeDeglAcCXTKYP5jE1b4A==';
//         byteAppKey: DotNet Byte;
//                         ErrorDetails: Text;
//                         ErrorMessage: Text;
//                         ErrorDetailsPos1: Integer;
//                         ErrorDetailsPos2: Integer;
//                         ConvertCode: DotNet Convert;
//                         TempBlob2: Record "99008535" temporary;
//                         TempBlob3: Record "99008535" temporary;
//                         EwbNo: Text;
//                         EwbDt: Text;
//                         EwbValidTill: Text;
//                         RecTransferShip: Record "5744";
//                         DupIRN: Text;
//                         InfoDtls: Text;
//                         Desc: Text;
//                         InfoDtlsPos1: Integer;
//                         InfoDtlsPos2: Integer;
//                         DescPos1: Integer;
//                         DescPos2: Integer;
//                         ErrorMsg: Label 'Duplicate IRN';
//         requestid: Integer;
//         IRNQRCodeUpdation: Report "50250";
//     begin

//         GetServiceProtol;

//         IF RecTransferShip.GET(DocumentNo) THEN
//           txtJsonRequest :=    DynamicJsonTransferReturn(DocumentNo)
//         ELSE
//           txtJsonRequest :=    DynamicJsonReturn(DocumentNo);

//         IF (USERID = 'ROBOSOFT.SUPPORT2') OR (USERID = 'ROBOSOFT.SUPPORT1') OR (USERID = 'GPUAE\FAHIM.AHMAD') THEN
//           MESSAGE(txtJsonRequest);

//         HttpClient  :=  HttpClient.HttpClient;
//         URI :=  URI.Uri(GenIRNURL);
//         HttpClient.BaseAddress(URI);

//         HttpClient.DefaultRequestHeaders.Add('user_name',UserName);
//         HttpClient.DefaultRequestHeaders.Add('password', Password);
//         HttpClient.DefaultRequestHeaders.Add('gstin', GSTIN);
//         HttpClient.DefaultRequestHeaders.Add('requestid',FORMAT(TODAY) + FORMAT(TIME));
//         HttpClient.DefaultRequestHeaders.Add( 'Authorization','Bearer' + ' ' +AuthToken);

//         HttpStringContent  :=  HttpStringContent.StringContent(txtJsonRequest,Encoding.UTF8, 'application/json');
//         HttpResponseMessage :=  HttpClient.PostAsync(URI, HttpStringContent).Result;
//         txtJsonResponse :=  HttpResponseMessage.Content.ReadAsStringAsync().Result;

//         JObject :=  JObject.JObject;
//         JObject := JObject.Parse(txtJsonResponse);
//         JObject :=  JObject.GetValue('success');
//         IF  UPPERCASE(JObject.ToString)  = 'FALSE' THEN  BEGIN

//           JObject :=  JObject.JObject;
//           JObject := JObject.Parse(txtJsonResponse);
//           JObject :=  JObject.GetValue('message');
//           ErrorMessage  :=  JObject.ToString;


//           IF STRPOS(ErrorMessage,ErrorMsg) <> 0 THEN BEGIN
//             JObject :=  JObject.JObject;
//             JObject := JObject.Parse(txtJsonResponse);
//             JObject :=  JObject.GetValue('result');
//             InfoDtls  :=  JObject.ToString;

//             InfoDtlsPos1  :=  STRPOS(InfoDtls, '{');
//             InfoDtlsPos2  :=  STRPOS(InfoDtls, '}');
//             InfoDtls  :=  COPYSTR(InfoDtls, InfoDtlsPos1+1, InfoDtlsPos2-1);
//             InfoDtlsPos2  :=  STRPOS(InfoDtls, '}');
//             InfoDtls  :=  COPYSTR(InfoDtls, 1, InfoDtlsPos2-1);

//             DescPos1  :=  STRPOS(InfoDtls, '{');
//             DescPos2  :=  STRLEN(InfoDtls);
//             Desc  := '{' + COPYSTR(InfoDtls, DescPos1+1, DescPos2) + '}';

//             JObject :=  JObject.JObject;
//             JObject := JObject.Parse(Desc);
//             JObject :=  JObject.GetValue('Irn');
//             DupIRN  :=  JObject.ToString;

//              IRNQRCodeUpdation.SetDocument(LocVar,DocumentNo,DupIRN);
//              IRNQRCodeUpdation.RUN;
//           END ELSE
//             ERROR(ErrorMessage)
//         END ELSE  BEGIN
//           JObject :=  JObject.JObject;
//           JObject := JObject.Parse(txtJsonResponse);
//           JObject :=  JObject.GetValue('message');
//           ErrorMessage  :=  JObject.ToString;

//           JObject :=  JObject.JObject;
//           JObject := JObject.Parse(txtJsonResponse);
//           JObject :=  JObject.GetValue('result');
//           txtResult  :=  JObject.ToString;

//           JObject :=  JObject.JObject;
//           JObject := JObject.Parse(txtResult);
//           JObject :=  JObject.GetValue('AckNo');
//           AckNo  :=  JObject.ToString;

//           JObject :=  JObject.JObject;
//           JObject := JObject.Parse(txtResult);
//           JObject :=  JObject.GetValue('AckDt');
//           AckDt  :=  JObject.ToString;

//           JObject :=  JObject.JObject;
//           JObject := JObject.Parse(txtResult);
//           JObject :=  JObject.GetValue('Irn');
//           Irn  :=  JObject.ToString;

//           JObject :=  JObject.JObject;
//           JObject := JObject.Parse(txtResult);
//           JObject :=  JObject.GetValue('SignedInvoice');
//           SignedInvoice  :=  JObject.ToString;

//           JObject :=  JObject.JObject;
//           JObject := JObject.Parse(txtResult);
//           JObject :=  JObject.GetValue('SignedQRCode');
//           SignedQRCode  :=  JObject.ToString;

//           JObject :=  JObject.JObject;
//           JObject := JObject.Parse(txtResult);
//           JObject :=  JObject.GetValue('EwbNo');
//           EwbNo  :=  JObject.ToString;

//           JObject :=  JObject.JObject;
//           JObject := JObject.Parse(txtResult);
//           JObject :=  JObject.GetValue('EwbDt');
//           EwbDt  :=  JObject.ToString;

//           JObject :=  JObject.JObject;
//           JObject := JObject.Parse(txtResult);
//           JObject :=  JObject.GetValue('EwbValidTill');
//           EwbValidTill  :=  JObject.ToString;

//           IF EwbNo <>'' THEN
//             EwbNo_EwbDate_EwbValidUpto := EwbNo+','+EwbDt+','+EwbValidTill;

//           MESSAGE(ErrorMessage);
//         END;
//     end;

//     [Scope('Internal')]
//     procedure CancelIRN(Irn: Text;CnlRsn: Text;CnlRem: Text;AuthToken: Text;var CancelDate: Text;Password: Text;Gstin: Text;user_name: Text)
//     var
//         Token: Label 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzY29wZSI6WyJnc3AiXSwiZXhwIjoxNTY2ODEzMzUwLCJhdXRob3JpdGllcyI6WyJST0xFX1NCX0VfQVBJX0dTVF9SRVRVUk5TIiwiUk9MRV9TQl9FX0FQSV9FV0IiXSwianRpIjoiYjlhNDUxZWEtNzZkOC00N2U3LTg2ZDktNzJhMTk2MjM2MmNhIiwiY2xpZW50X2lkIjoiRTRCMTcyNDMzNkE5NDI5Q0ExQjM4M0ZEODAzMjBCOEYifQ.1BGkFnecJeY0aaQveGdadj9zU5iRe4qaMJ81HKzKOh8';
//         HttpClient: DotNet HttpClient;
//                         URI: DotNet Uri;
//                         ReqHdr: DotNet HttpRequestHeaders;
//                         HttpStringContent: DotNet StringContent;
//                         txtJsonResult: Text;
//                         HttpResponseMessage: DotNet HttpResponseMessage;
//                         JObject: DotNet JObject;
//                         Encoding: DotNet Encoding;
//                         txtSuccess: Text;
//                         txtJsonResponse: Text;
//                         txtResult: Text;
//                         txtJsonRequest: Text;
//                         TextAppKey: Label 'dN+eAtmvwlz/2rsFe5dXkTps08mMko5Q3uvRsYGIPaT9/BcsfwlR8vnuz47VBRooif2Z9wnCUogApf28IRb91OMPs81U9ON7uvE9qyWFhM+8gBj6kFlwj9oBYfRAiO8Ht8YEqXFs+ZCQkFIu3PsvfKl26w1j8xj1HcaPYeVhchJtvp/zBuo8Uk9fwFDeZRjpJwgnJwLw/wx5O2sydhuUm7srI/FIWZVch2+n9TMRueK4twHm/m7xEQQl3k4kmZTguYa9FmsSRb0HDhtqQsOfz7pB7wm6oVzJR01FKn8fTx2diuZSSy6ycc5o6xM65Vj5EkeDeglAcCXTKYP5jE1b4A==';
//         byteAppKey: DotNet Byte;
//                         ErrorDetails: Text;
//                         ErrorMessage: Text;
//                         ErrorDetailsPos1: Integer;
//                         ErrorDetailsPos2: Integer;
//                         dtJSONConvertor: DotNet JsonConvert;
//                         txtData: Text;
//                         ConvertCode: DotNet Convert;
//     begin

//         GetServiceProtol;

//         txtJsonRequest := CreateJsonCancelIRN(Irn,CnlRsn,CnlRem);

//         HttpClient  :=  HttpClient.HttpClient;
//         URI :=  URI.Uri(CancelIRNURL);
//         HttpClient.BaseAddress(URI);


//         HttpClient.DefaultRequestHeaders.Add('user_name',user_name);
//         HttpClient.DefaultRequestHeaders.Add('password', Password);
//         HttpClient.DefaultRequestHeaders.Add('gstin', Gstin);
//         HttpClient.DefaultRequestHeaders.Add('requestid',FORMAT(TODAY) + FORMAT(TIME));
//         HttpClient.DefaultRequestHeaders.Add( 'Authorization','Bearer' + ' ' +AuthToken);

//         HttpStringContent  := HttpStringContent.StringContent(txtJsonRequest,Encoding.UTF8, 'application/json');
//         HttpResponseMessage :=  HttpClient.PostAsync(CancelIRNURL, HttpStringContent).Result;
//         txtJsonResponse :=  HttpResponseMessage.Content.ReadAsStringAsync().Result;

//         //MESSAGE('txtJsonResponse1  = ' + txtJsonResponse);

//         JObject :=  JObject.JObject;
//         JObject := JObject.Parse(txtJsonResponse);
//         JObject :=  JObject.GetValue('success');
//         IF  JObject.ToString  = 'False' THEN  BEGIN
//           JObject :=  JObject.JObject;
//           JObject := JObject.Parse(txtJsonResponse);
//           JObject :=  JObject.GetValue('message');
//           ErrorMessage  :=  JObject.ToString;

//           ERROR(ErrorMessage)
//         END ELSE  BEGIN
//           JObject :=  JObject.JObject;
//           JObject := JObject.Parse(txtJsonResponse);
//           JObject :=  JObject.GetValue('message');
//           ErrorMessage  :=  JObject.ToString;

//           JObject :=  JObject.JObject;
//           JObject := JObject.Parse(txtJsonResponse);
//           JObject :=  JObject.GetValue('result');
//           txtResult  :=  JObject.ToString;

//           JObject :=  JObject.JObject;
//           JObject := JObject.Parse(txtResult);
//           JObject :=  JObject.GetValue('CancelDate');
//           CancelDate  :=  JObject.ToString;

//           MESSAGE(ErrorMessage);
//         END;
//     end;

//     local procedure CreateJsonCancelIRN(Irn: Text;CnlRsn: Text;CnlRem: Text): Text
//     var
//         StringBuilder: DotNet StringBuilder;
//                            StringWriter: DotNet StringWriter;
//                            JSON: DotNet String;
//                            JSONTextWriter: DotNet JsonTextWriter;
//                            JSONTextWriter2: DotNet JsonWriter;
//     begin
//         StringBuilder :=  StringBuilder.StringBuilder;
//         StringWriter  :=  StringWriter.StringWriter(StringBuilder);
//         JSONTextWriter  :=  JSONTextWriter.JsonTextWriter(StringWriter);


//         JSONTextWriter.WriteStartObject;

//         CreateJsonAttributeGetToken('irn',  Irn,JSONTextWriter,FALSE);
//         CreateJsonAttributeGetToken('Cnlrsn',  CnlRsn,JSONTextWriter,FALSE);
//         CreateJsonAttributeGetToken('Cnlrem',  CnlRem,JSONTextWriter,FALSE);
//         JSONTextWriter.WriteEndObject;

//         EXIT(StringBuilder.ToString);
//     end;

//     [Scope('Internal')]
//     procedure GenerateIRNForPurchaseCrMemo(DocumentNo: Text;AuthToken: Text;var AckNo: Text;var AckDt: Text;var Irn: Text;var SignedInvoice: Text;var SignedQRCode: Text;Password: Text;GSTIN: Text;UserName: Text;AddEwbDtls: Boolean;var EwbNo_EwbDate_EwbValidUpto: Text)
//     var
//         Token: Label 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzY29wZSI6WyJnc3AiXSwiZXhwIjoxNTY2ODEzMzUwLCJhdXRob3JpdGllcyI6WyJST0xFX1NCX0VfQVBJX0dTVF9SRVRVUk5TIiwiUk9MRV9TQl9FX0FQSV9FV0IiXSwianRpIjoiYjlhNDUxZWEtNzZkOC00N2U3LTg2ZDktNzJhMTk2MjM2MmNhIiwiY2xpZW50X2lkIjoiRTRCMTcyNDMzNkE5NDI5Q0ExQjM4M0ZEODAzMjBCOEYifQ.1BGkFnecJeY0aaQveGdadj9zU5iRe4qaMJ81HKzKOh8';
//         HttpClient: DotNet HttpClient;
//                         URI: DotNet Uri;
//                         ReqHdr: DotNet HttpRequestHeaders;
//                         HttpStringContent: DotNet StringContent;
//                         txtJsonResult: Text;
//                         HttpResponseMessage: DotNet HttpResponseMessage;
//                         JObject: DotNet JObject;
//                         Encoding: DotNet Encoding;
//                         txtSuccess: Text;
//                         txtJsonResponse: Text;
//                         txtResult: Text;
//                         txtJsonRequest: Text;
//                         TextAppKey: Label 'dN+eAtmvwlz/2rsFe5dXkTps08mMko5Q3uvRsYGIPaT9/BcsfwlR8vnuz47VBRooif2Z9wnCUogApf28IRb91OMPs81U9ON7uvE9qyWFhM+8gBj6kFlwj9oBYfRAiO8Ht8YEqXFs+ZCQkFIu3PsvfKl26w1j8xj1HcaPYeVhchJtvp/zBuo8Uk9fwFDeZRjpJwgnJwLw/wx5O2sydhuUm7srI/FIWZVch2+n9TMRueK4twHm/m7xEQQl3k4kmZTguYa9FmsSRb0HDhtqQsOfz7pB7wm6oVzJR01FKn8fTx2diuZSSy6ycc5o6xM65Vj5EkeDeglAcCXTKYP5jE1b4A==';
//         byteAppKey: DotNet Byte;
//                         ErrorDetails: Text;
//                         ErrorMessage: Text;
//                         ErrorDetailsPos1: Integer;
//                         ErrorDetailsPos2: Integer;
//                         ConvertCode: DotNet Convert;
//                         TempBlob2: Record "99008535" temporary;
//                         TempBlob3: Record "99008535" temporary;
//                         EwbNo: Text;
//                         EwbDt: Text;
//                         EwbValidTill: Text;
//                         RecPurHeader: Record "124";
//                         IRNQRCodeUpdation: Report "50250";
//                         DupIRN: Text;
//                         InfoDtls: Text;
//                         Desc: Text;
//                         InfoDtlsPos1: Integer;
//                         InfoDtlsPos2: Integer;
//                         DescPos1: Integer;
//                         DescPos2: Integer;
//                         ErrorMsg: Label 'Duplicate IRN';
//     begin
//         //RSPL_28117_AviMali_11122020_EINV  <<
//         GetServiceProtol;

//         IF RecPurHeader.GET(DocumentNo) THEN
//           txtJsonRequest :=    DynamicJsonReturnForPurchaseCrMemo(DocumentNo,AddEwbDtls);

//         IF (USERID = 'ROBOSOFT.SUPPORT2') OR (USERID = 'ROBOSOFT.SUPPORT1') OR (USERID = 'GPUAE\FAHIM.AHMAD') THEN
//           MESSAGE(txtJsonRequest);

//         HttpClient  :=  HttpClient.HttpClient;
//         URI :=  URI.Uri(GenIRNURL);
//         HttpClient.BaseAddress(URI);

//         HttpClient.DefaultRequestHeaders.Add('user_name',UserName);
//         HttpClient.DefaultRequestHeaders.Add('password', Password);
//         HttpClient.DefaultRequestHeaders.Add('gstin', GSTIN);
//         HttpClient.DefaultRequestHeaders.Add('requestid',FORMAT(TODAY) + FORMAT(TIME));
//         HttpClient.DefaultRequestHeaders.Add( 'Authorization','Bearer' + ' ' +AuthToken);

//         HttpStringContent  :=  HttpStringContent.StringContent(txtJsonRequest,Encoding.UTF8, 'application/json');
//         HttpResponseMessage :=  HttpClient.PostAsync(URI, HttpStringContent).Result;
//         txtJsonResponse :=  HttpResponseMessage.Content.ReadAsStringAsync().Result;

//         JObject :=  JObject.JObject;
//         JObject := JObject.Parse(txtJsonResponse);
//         JObject :=  JObject.GetValue('success');
//         IF  UPPERCASE(JObject.ToString)  = 'FALSE' THEN  BEGIN

//           JObject :=  JObject.JObject;
//           JObject := JObject.Parse(txtJsonResponse);
//           JObject :=  JObject.GetValue('message');
//           ErrorMessage  :=  JObject.ToString;


//           IF STRPOS(ErrorMessage,ErrorMsg) <> 0 THEN BEGIN
//             JObject :=  JObject.JObject;
//             JObject := JObject.Parse(txtJsonResponse);
//             JObject :=  JObject.GetValue('result');
//             InfoDtls  :=  JObject.ToString;

//             InfoDtlsPos1  :=  STRPOS(InfoDtls, '{');
//             InfoDtlsPos2  :=  STRPOS(InfoDtls, '}');
//             InfoDtls  :=  COPYSTR(InfoDtls, InfoDtlsPos1+1, InfoDtlsPos2-1);
//             InfoDtlsPos2  :=  STRPOS(InfoDtls, '}');
//             InfoDtls  :=  COPYSTR(InfoDtls, 1, InfoDtlsPos2-1);

//             DescPos1  :=  STRPOS(InfoDtls, '{');
//             DescPos2  :=  STRLEN(InfoDtls);
//             Desc  := '{' + COPYSTR(InfoDtls, DescPos1+1, DescPos2) + '}';

//             JObject :=  JObject.JObject;
//             JObject := JObject.Parse(Desc);
//             JObject :=  JObject.GetValue('Irn');
//             DupIRN  :=  JObject.ToString;

//              IRNQRCodeUpdation.SetDocument(LocVar,DocumentNo,DupIRN);
//              IRNQRCodeUpdation.RUN;
//           END ELSE
//             ERROR(ErrorMessage)
//         END ELSE  BEGIN
//           JObject :=  JObject.JObject;
//           JObject := JObject.Parse(txtJsonResponse);
//           JObject :=  JObject.GetValue('message');
//           ErrorMessage  :=  JObject.ToString;

//           JObject :=  JObject.JObject;
//           JObject := JObject.Parse(txtJsonResponse);
//           JObject :=  JObject.GetValue('result');
//           txtResult  :=  JObject.ToString;

//           JObject :=  JObject.JObject;
//           JObject := JObject.Parse(txtResult);
//           JObject :=  JObject.GetValue('AckNo');
//           AckNo  :=  JObject.ToString;

//           JObject :=  JObject.JObject;
//           JObject := JObject.Parse(txtResult);
//           JObject :=  JObject.GetValue('AckDt');
//           AckDt  :=  JObject.ToString;

//           JObject :=  JObject.JObject;
//           JObject := JObject.Parse(txtResult);
//           JObject :=  JObject.GetValue('Irn');
//           Irn  :=  JObject.ToString;

//           JObject :=  JObject.JObject;
//           JObject := JObject.Parse(txtResult);
//           JObject :=  JObject.GetValue('SignedInvoice');
//           SignedInvoice  :=  JObject.ToString;

//           JObject :=  JObject.JObject;
//           JObject := JObject.Parse(txtResult);
//           JObject :=  JObject.GetValue('SignedQRCode');
//           SignedQRCode  :=  JObject.ToString;

//           JObject :=  JObject.JObject;
//           JObject := JObject.Parse(txtResult);
//           JObject :=  JObject.GetValue('EwbNo');
//           EwbNo  :=  JObject.ToString;

//           JObject :=  JObject.JObject;
//           JObject := JObject.Parse(txtResult);
//           JObject :=  JObject.GetValue('EwbDt');
//           EwbDt  :=  JObject.ToString;

//           JObject :=  JObject.JObject;
//           JObject := JObject.Parse(txtResult);
//           JObject :=  JObject.GetValue('EwbValidTill');
//           EwbValidTill  :=  JObject.ToString;

//           IF EwbNo <>'' THEN
//             EwbNo_EwbDate_EwbValidUpto := EwbNo+','+EwbDt+','+EwbValidTill;

//           MESSAGE(ErrorMessage);
//         END;
//         //RSPL_28117_AviMali_11122020_EINV  >>
//     end;

//     [Scope('Internal')]
//     procedure GetIRNDetails(AuthToken: Text;Sek: Text;Irn: Text;Client_ID: Text;Password: Text;Gstin: Text;user_name: Text)
//     var
//         HttpClient: DotNet HttpClient;
//                         URI: DotNet Uri;
//                         ReqHdr: DotNet HttpRequestHeaders;
//                         HttpStringContent: DotNet StringContent;
//                         txtJsonResult: Text;
//                         HttpResponseMessage: DotNet HttpResponseMessage;
//                         JObject: DotNet JObject;
//                         Encoding: DotNet Encoding;
//                         txtJsonResponse: Text;
//                         txtResult: Text;
//                         txtJsonRequest: Text;
//                         FileName: Text;
//                         TestFile: File;
//                         FileMgt: Codeunit "419";
//                         MyOutStream: OutStream;
//                         byteAppKey: DotNet Byte;
//                         ErrorDetails: Text;
//                         ErrorMessage: Text;
//                         ErrorDetailsPos1: Integer;
//                         ErrorDetailsPos2: Integer;
//                         dtJSONConvertor: DotNet JsonConvert;
//                         txtData: Text;
//                         ConvertCode: DotNet Convert;
//     begin

//         CLEARALL;
//         HttpClient  :=  HttpClient.HttpClient;

//         URI :=  URI.Uri(GetIrnDetailsText + Irn);
//         HttpClient.BaseAddress(URI);

//         HttpClient.DefaultRequestHeaders.Add('user_name',user_name);
//         HttpClient.DefaultRequestHeaders.Add('password', Password);
//         HttpClient.DefaultRequestHeaders.Add('gstin', Gstin);
//         HttpClient.DefaultRequestHeaders.Add('requestid',FORMAT(TODAY) + FORMAT(TIME));
//         HttpClient.DefaultRequestHeaders.Add( 'Authorization','Bearer' + ' ' +AuthToken);

//         HttpStringContent  :=  HttpStringContent.StringContent(txtJsonRequest,Encoding.UTF8, 'application/json');
//         HttpResponseMessage :=  HttpClient.GetAsync(URI).Result;
//         txtJsonResponse :=  HttpResponseMessage.Content.ReadAsStringAsync().Result;

//         JObject :=  JObject.JObject;
//         JObject := JObject.Parse(txtJsonResponse);
//         JObject :=  JObject.GetValue('success');
//         IF  JObject.ToString  = 'false' THEN  BEGIN
//           JObject :=  JObject.JObject;
//           JObject := JObject.Parse(txtJsonResponse);
//           JObject :=  JObject.GetValue('message');
//           ErrorDetails :=  JObject.ToString;
//           ERROR(ErrorDetails)
//         END ELSE  BEGIN
//           JObject :=  JObject.JObject;
//           JObject := JObject.Parse(txtJsonResponse);
//           JObject :=  JObject.GetValue('result');
//           txtResult  :=  JObject.ToString;
//         END;


//         //Save in notepad Begin
//         FileName := FileMgt.SaveFileDialog('Window Title','.txt','Text files *.txt|*.txt');
//         IF  FileName  = ''  THEN
//           EXIT;
//         TestFile.CREATE(FileName);
//         TestFile.CREATEOUTSTREAM(MyOutStream);
//         MyOutStream.WRITETEXT(txtResult);
//         HYPERLINK(FileName);
//         //Save in notepad End
//     end;

//     [Scope('Internal')]
//     procedure GetGSTINDetails(AuthToken: Text;Sek: Text;Client_ID: Text;Password: Text;Gstin: Text;user_name: Text;GSTRegNo: Text;ShowMsg: Boolean)
//     var
//         HttpClient: DotNet HttpClient;
//                         URI: DotNet Uri;
//                         ReqHdr: DotNet HttpRequestHeaders;
//                         HttpStringContent: DotNet StringContent;
//                         txtJsonResult: Text;
//                         HttpResponseMessage: DotNet HttpResponseMessage;
//                         JObject: DotNet JObject;
//                         Encoding: DotNet Encoding;
//                         txtJsonResponse: Text;
//                         txtResult: Text;
//                         txtJsonRequest: Text;
//                         FileName: Text;
//                         TestFile: File;
//                         FileMgt: Codeunit "419";
//                         MyOutStream: OutStream;
//                         byteAppKey: DotNet Byte;
//                         ErrorDetails: Text;
//                         ErrorMessage: Text;
//                         ErrorDetailsPos1: Integer;
//                         ErrorDetailsPos2: Integer;
//                         dtJSONConvertor: DotNet JsonConvert;
//                         txtData: Text;
//                         ConvertCode: DotNet Convert;
//     begin
//         CLEARALL;
//         HttpClient  :=  HttpClient.HttpClient;

//         URI :=  URI.Uri(GetGSTINDetailsText + GSTRegNo);

//         HttpClient.BaseAddress(URI);
//         HttpClient.DefaultRequestHeaders.Add('user_name',user_name);
//         HttpClient.DefaultRequestHeaders.Add('password', Password);
//         HttpClient.DefaultRequestHeaders.Add('gstin', Gstin);
//         HttpClient.DefaultRequestHeaders.Add('requestid',FORMAT(TODAY) + FORMAT(TIME));
//         HttpClient.DefaultRequestHeaders.Add( 'Authorization','Bearer' + ' ' +AuthToken);

//         HttpResponseMessage :=  HttpClient.GetAsync(URI).Result;
//         txtJsonResponse :=  HttpResponseMessage.Content.ReadAsStringAsync().Result;

//         JObject :=  JObject.JObject;
//         JObject := JObject.Parse(txtJsonResponse);
//         JObject :=  JObject.GetValue('success');
//         IF  JObject.ToString  = 'false' THEN  BEGIN
//           JObject :=  JObject.JObject;
//           JObject := JObject.Parse(txtJsonResponse);
//           JObject :=  JObject.GetValue('message');
//           ErrorDetails :=  JObject.ToString;
//           ERROR(ErrorDetails)
//         END ELSE  BEGIN
//           IF  ShowMsg THEN
//             MESSAGE('GST Registrarion No. is valid');
//           JObject :=  JObject.JObject;
//           JObject := JObject.Parse(txtJsonResponse);
//           JObject :=  JObject.GetValue('result');
//           txtResult  :=  JObject.ToString;
//         END;


//         //Save in notepad Begin
//         IF  NOT CONFIRM('Do you want to save details to notepad?') THEN
//           EXIT;
//         FileName := FileMgt.SaveFileDialog('Window Title','.txt','Text files *.txt|*.txt');
//         IF  FileName  = ''  THEN
//           EXIT;
//         TestFile.CREATE(FileName);
//         TestFile.CREATEOUTSTREAM(MyOutStream);
//         MyOutStream.WRITETEXT(txtResult);
//         HYPERLINK(FileName);
//     end;
// }

