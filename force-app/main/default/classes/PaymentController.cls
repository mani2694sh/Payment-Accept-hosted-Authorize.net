public class PaymentController {
    
    public static string apilogin;  
    public static string apitranskey;
    public string TimeStamp{get;set;}
    public Integer sequence{get;set;}
    public static string finger;
    
    public string token {get;set;}
	public String firstName {get;set;}
    public String lastName {get;set;}
    public String Address {get;set;}
    public String city {get;set;}
    public String state {get;set;}
    public String zip {get;set;}
    public String email {get;set;}
    public String country {get;set;}
	public String amount {get;set;}
    public list<Driving_Licence__c> dlrec;
    public ID custID;
    
	public PageReference pr; 

    public PaymentController(){
        try{
            String custPayProfileId;
            String custProfileId;
            
            dlrec = [Select id, name, last_name__c, address__c, email_id__c , city__c,state__c,country__c,fee__c,pin_code__c,createdById from driving_licence__c];
            for(driving_licence__c dl : dlrec){
                if(dl.CreatedById==UserInfo.getUserId()){
                    custID = dl.Id;
                    firstname = dl.name;
                    lastname = dl.Last_Name__c;
                    email = dl.Email_ID__c;
                    address = dl.Address__c;
                    city = dl.City__c;
                    state = dl.State__c;
                    country = dl.Country__c;
                    zip = string.valueOf(dl.PIN_CODE__c);
                    amount = string.valueOf(dl.Fee__c);
                }
            }
            amount = '5.76';
                        
            pr = new PageReference('/apex/iframepayment');
            String json='{'+
            '  "getHostedPaymentPageRequest": {'+
            '    "merchantAuthentication": {'+
            '      "name": "6A5C643kLez",'+
            '      "transactionKey": "5hRyQ3F8m945y7Mc"'+
            '    },'+
            '    "transactionRequest": {'+
            '      "transactionType": "authCaptureTransaction",'+
            '      "amount": '+amount+','+
            //'      "order":{  '+
            //'			"invoiceNumber": "INV-12345"'+
            //'	  		"description":"Driving License"'+
            //'      },'+
            '      "profile": {'+
            '        "customerProfileId": "123456789"'+
            '      },'+
            '      "customer": {'+
            '        "email": "ellen@mail.com"'+
            '      },'+
            '      "billTo": {'+
            '        "firstName": "Ellen",'+
            '        "lastName": "Johnson",'+
            '        "company": "Souveniropolis",'+
            '        "address": "14 Main Street",'+
            '        "city": "Pecan Springs",'+
            '        "state": "TX",'+
            '        "zip": "44628",'+
            '        "country": "USA"'+
            '      }'+
            '    },'+
            '\"hostedPaymentSettings\": {'+
            '      \"setting\": [{'+ 
            '        \"settingName\": \"hostedPaymentReturnOptions\",'+      //0
            '        \"settingValue\": \"{\\\"showReceipt\\\": false, \\\"url\\\": \\\"	https://aithent-developer-edition.ap27.force.com/s/ \\\", \\\"urlText\\\": \\\"Continue\\\", \\\"cancelUrl\\\": \\\"https://aithent2-dev-ed--c.visualforce.com/apex/testPayment\\\", \\\"cancelUrlText\\\": \\\"Cancel\\\"}\"'+
            //'        \"settingValue\": \"{\\\"showReceipt\\\": false'+
            '      }, {'+
            '        \"settingName\": \"hostedPaymentButtonOptions\",'+      //1
            '        \"settingValue\": \"{\\\"text\\\": \\\"Pay\\\"}\"'+
            '      }, {'+
            '        \"settingName\": \"hostedPaymentStyleOptions\",'+       //2
            '        \"settingValue\": \"{\\\"bgColor\\\": \\\"blue\\\"}\"'+
            '      }, {'+
            '        \"settingName\": \"hostedPaymentPaymentOptions\",'+       //3
            '        \"settingValue\": \"{\\\"cardCodeRequired\\\": true, \\\"showCreditCard\\\": true, \\\"showBankAccount\\\": false}\"'+
            '      }, {'+
            '        \"settingName\": \"hostedPaymentSecurityOptions\",'+        //4
            '        \"settingValue\": \"{\\\"captcha\\\": false}\"'+
            '      }, {'+
            '        \"settingName\": \"hostedPaymentShippingAddressOptions\",'+          //5
            '        \"settingValue\": \"{\\\"show\\\": false, \\\"required\\\": false}\"'+
            '      }, {'+
            '        \"settingName\": \"hostedPaymentBillingAddressOptions\",'+      //6
            '        \"settingValue\": \"{\\\"show\\\": true, \\\"required\\\": false}\"'+
            '      }, {'+
            '        \"settingName\": \"hostedPaymentCustomerOptions\",'+        //7
            '        \"settingValue\": \"{\\\"showEmail\\\": true, \\\"requiredEmail\\\": false, \\\"addPaymentProfile\\\": true}\"'+
            '      }, {'+     
            '        \"settingName\": \"hostedPaymentOrderOptions\",'+        //8
            '        \"settingValue\": \"{\\\"show\\\": true, \\\"merchantName\\\": \\\"Aithent\\\"}\"'+
            '      }, {'+
            '        \"settingName\": \"hostedPaymentIFrameCommunicatorUrl\",'+       //9
            '        \"settingValue\": \"{\\\"url\\\": \\\"https://aithent2-dev-ed--c.visualforce.com/apex/iframepayment\\\"}\"'+
            '      }]'+
            '    }'+
            '  }'+
            '}';
            
            String json1='{'+
            '  "getHostedPaymentPageRequest": {'+
            '    "merchantAuthentication": {'+
            '      "name": "6A5C643kLez",'+
            '      "transactionKey": "5hRyQ3F8m945y7Mc"'+
            '    },'+
            '    "transactionRequest": {'+
            '      "transactionType": "authCaptureTransaction",'+
            '      "order":{  '+
            '			"invoiceNumber": "INV-12345"'+
            '	  		"description":"Driving License"'+
            '      },'+
            '      "amount": '+amount+','+ 
            '      "profile": {'+
            '        "customerProfileId": '+ custID +''+
            '      },'+
            '      "customer": {'+
            '        "email": "ellen@mail.com"'+
            '      },'+
            '      "billTo": {'+
            '        "firstName": '+firstname+','+
            '        "lastName": '+ lastname +','+
            '        "address": '+ address +','+
            '        "city": '+ city +','+
            '        "state": '+ state +','+
            '        "zip": '+ zip +','+
            '        "country": '+ country +''+
            '      }'+
            '    },'+
            '\"hostedPaymentSettings\": {'+
            '      \"setting\": [{'+
            '        \"settingName\": \"hostedPaymentReturnOptions\",'+
            '        \"settingValue\": \"{\\\"showReceipt\\\": false, \\\"url\\\": \\\"https://aithent2-dev-ed--c.visualforce.com/apex/test3page\\\", \\\"urlText\\\": \\\"Continue\\\", \\\"cancelUrl\\\": \\\"https://aithent2-dev-ed--c.visualforce.com/apex/test3page\\\", \\\"cancelUrlText\\\": \\\"Cancel\\\"}\"'+
            '      }, {'+
            '        \"settingName\": \"hostedPaymentButtonOptions\",'+
            '        \"settingValue\": \"{\\\"text\\\": \\\"Pay\\\"}\"'+
            '      }, {'+
            '        \"settingName\": \"hostedPaymentStyleOptions\",'+
            '        \"settingValue\": \"{\\\"bgColor\\\": \\\"blue\\\"}\"'+
            '      }, {'+
            '        \"settingName\": \"hostedPaymentPaymentOptions\",'+
            '        \"settingValue\": \"{\\\"cardCodeRequired\\\": false, \\\"showCreditCard\\\": true, \\\"showBankAccount\\\": true}\"'+
            '      }, {'+
            '        \"settingName\": \"hostedPaymentSecurityOptions\",'+
            '        \"settingValue\": \"{\\\"captcha\\\": false}\"'+
            '      }, {'+
            '        \"settingName\": \"hostedPaymentShippingAddressOptions\",'+
            '        \"settingValue\": \"{\\\"show\\\": false, \\\"required\\\": false}\"'+
            '      }, {'+
            '        \"settingName\": \"hostedPaymentBillingAddressOptions\",'+
            '        \"settingValue\": \"{\\\"show\\\": true, \\\"required\\\": false}\"'+
            '      }, {'+
            '        \"settingName\": \"hostedPaymentCustomerOptions\",'+
            '        \"settingValue\": \"{\\\"showEmail\\\": false, \\\"requiredEmail\\\": false, \\\"addPaymentProfile\\\": true}\"'+
            '      }, {'+
            '        \"settingName\": \"hostedPaymentOrderOptions\",'+
            '        \"settingValue\": \"{\\\"show\\\": true, \\\"merchantName\\\": \\\"Aithent\\\"}\"'+
            '      }, {'+
            '        \"settingName\": \"hostedPaymentIFrameCommunicatorUrl\",'+
            '        \"settingValue\": \"{\\\"url\\\": \\\"https://aithent2-dev-ed--c.visualforce.com/apex/iframepayment\\\"}\"'+
            //'        \"settingValue\": \"{\\\"url\\\": \\\"https://aithent2-dev-ed--c.visualforce.com/apex/iframepayment\\\"}\"'+
            //'        \"settingValue\": \"{\\\"url\\\": \\\"https://aithent-developer-edition.ap27.force.com/transport/s/\\\"}\"'+
            '      }]'+
            '    }'+
            '  }'+
            '}'; 
            
            //String CreateCustProString = gen.getAsString();
            //System.debug('CreateCustProString==>'+CreateCustProString);
            //System.debug('CreateCustProString==>'+gen);
                
            System.debug('CreateCustProString==>'+json);
                
            Http http1 = new Http();
            HttpRequest req1 = new HttpRequest();
            req1.setEndpoint('https://apitest.authorize.net/xml/v1/request.api');
            req1.Setheader('Content-Type','application/json');
            req1.setMethod('POST');
            //req1.setbody(CreateCustProString);
            req1.setbody(json);
            
            HttpResponse res1 = http1.send(req1);
            system.debug('res1==>' +res1);
            system.debug('res1==>' +res1.getBody());
            
            if(res1.getStatusCode() == 200){
                String str=res1.getbody().escapeUnicode();
                string FinalJSON=str.replaceall('uFEFF','');
                FinalJSON=FinalJSON.replaceall('\\\\','');
                
                 system.debug(FinalJSON);    
                
                PaymentDLjson2apex pja = new PaymentDLjson2apex();
                pja=(PaymentDLjson2apex) System.JSON.deserialize(FinalJSON, PaymentDLjson2apex.class);
                token = pja.token;
                system.debug(token);
            }
            
            //Enumeration eParams =  req1.getParameterNames();
            //System.JSONParser();
            
            //PaymentDLjson2apex.cls_messages custProfileMsg2 = pja.messages;
            //List<PaymentDLjson2apex.cls_message> custProfileSubMsg2 = custProfileMsg2.message;
            
            //system.debug(custProfileMsg2);
            //system.debug(custProfileSubMsg2);
            
            
            //PaymentResponseDL res = new PaymentResponseDL();
            
            
    }catch(Exception e){
            system.debug(e.getMessage()+ ' - lineMsg: '+e.getLineNumber()+' - '+ e.getStackTraceString());
        }	
    }    
}