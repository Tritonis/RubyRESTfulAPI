require 'net/http'
require 'json'
require 'uri'

=begin 
Depending on the access level/type of API key supplied, some of
these methods will return 403 error codes(forbidden). Enterprise level
API keys have access to any/all of the GET requests, but nothing else. 
Customer level API keys have access to GET, POST, PUT, and DELETE, but only
for valid accounts which are associated with the customer API key. 
=end
#Enterprise APIKey
#APIkey = 'ENTf52dd79967987b3ba94904e83cc26e47'

#Customer APIKey
APIkey = 'CUSTf52dd79967987b3ba94904e83cc26e47'
baseURL = 'http://api.reimaginebanking.com:80'

=begin
Testing data
Customer ID: 5516c07ba520e0066c9ac53c	
Json for updating cusomter data: 	
myJson ='{
 		 "address": {
  		   "street_number": "424 Waupelani Drive",
    	   "street_name": "",
  		   "city": "state college",
   		   "state": "PA",
    	   "zip": "16801"
  		}
	}'

=end
	json ='{
 		 "address": {
  		   "street_number": "424 Waupelani Drive",
    	   "street_name": "",
  		   "city": "state college",
   		   "state": "PA",
    	   "zip": "16801"
  		}
	}'
#GET requests

def getATMS
	url = "http://api.reimaginebanking.com:80/atms?key=#{APIkey}"
	resp = Net::HTTP.get_response(URI.parse(url))
	data = resp.body
	puts(data)
end

def getATM(id)
	url = "http://api.reimaginebanking.com:80/atms/#{id}?key=#{APIkey}"
	resp = Net::HTTP.get_response(URI.parse(url))
	data = resp.body
end

def getCustomers
	url = "http://api.reimaginebanking.com:80/customers?key=#{APIkey}"
	resp = Net::HTTP.get_response(URI.parse(url))
	data = resp.body
	puts(data)
end

def getCustomer(id)
	url = "http://api.reimaginebanking.com:80/customers/#{id}?key=#{APIkey}"
	resp = Net::HTTP.get_response(URI.parse(url))
	data = resp.body
	puts(data)
end

def getCustAccts(custID)
	url = "http://api.reimaginebanking.com:80/customers/#{custID}/accounts?key=#{APIkey}"
	resp = Net::HTTP.get_response(URI.parse(url))
	data = resp.body
	puts(data)
end
#get all 
def getBills(custID)
	url = "http://api.reimaginebanking.com:80/customers/#{custID}/bills?key=#{APIkey}"
	resp = Net::HTTP.get_response(URI.parse(url))
	data = resp.body
	puts(data)
end

#cust = 5516c07ba520e0066c9ac53b
#bill = null
def getCustBill(custID, billID)
	 url = "http://api.reimaginebanking.com:80/customers/#{custID}/bills/#{billID}?key=#{APIkey}"
	 resp = Net::HTTP.get_response(URI.parse(url))
	 data = resp.body
	 puts(data)
end

#Gets all accounts of a given type.
#Possible arguments are: Savings, Credit Card, or Checking.
def getAllAccounts(type)
	url = "http://api.reimaginebanking.com:80/accounts?type=#{type}&key=#{APIkey}"
	resp = Net::HTTP.get_response(URI.parse(url))
	data = resp.body
	puts(data)
end

def getAccById(accID)
	url = "http://api.reimaginebanking.com:80/accounts/#{accID}?key=#{APIkey}"
	resp = Net::HTTP.get_response(URI.parse(url))
	data = resp.body
	puts(data)
end
#Get the customer for the given account.
def getCustForAcc(accID)
	url = "http://api.reimaginebanking.com:80/accounts/#{accID}/customer?key=#{APIkey}"
	resp = Net::HTTP.get_response(URI.parse(url))
	data = resp.body
	puts(data)
end
#Get all bills for a specific account
def getAccBills(accID)
	url = "http://api.reimaginebanking.com:80/accounts/#{accID}/bills?key=#{APIkey}"
	resp = Net::HTTP.get_response(URI.parse(url))
	data = resp.body
	puts(data)
end
#get a specific bill from a specific account
def findAccBill(accID, billID)
	url ="http://api.reimaginebanking.com:80/accounts/#{accID}/bills/#{billID}?key=#{APIkey}"
	resp = Net::HTTP.get_response(URI.parse(url))
	data = resp.body
	puts(data)
end
#Find all transactions associated with an account
def getAccTransactions(accID)
	url = "http://api.reimaginebanking.com:80/accounts/#{accID}/transactions?key=#{APIkey}"
	resp = Net::HTTP.get_response(URI.parse(url))
	data = resp.body
	puts(data)
end
#Find a transaction by id for a specific accoutnt id
def findAccTransaction(accID, tranID)
	url = "http://api.reimaginebanking.com:80/accounts/#{accID}/transactions/#{tranID}?key=#{APIkey}"
	resp = Net::HTTP.get_response(URI.parse(url))
	data = resp.body
	puts(data)
end

#get all branches
def getBranches
	url = "http://api.reimaginebanking.com:80/branches?key=#{APIkey}"
	resp = Net::HTTP.get_response(URI.parse(url))
	data = resp.body
	puts(data)
end

#find branch by id
def findBranch(branchID)
	url = "http://api.reimaginebanking.com:80/branches/#{APIkey}?key=#{APIkey}"
	resp = Net::HTTP.get_response(URI.parse(url))
	data = resp.body
	puts(data)
end



#PUT requests

#update customer info

def updateCustomer(custID, json)
	url = "http://api.reimaginebanking.com:80/customers/#{custID}?key=#{APIkey}"
	uri = URI.parse(url)
	myHash = JSON.parse(json)
	puts(myHash)
	http = Net::HTTP.new(uri.host, uri.port)
	puts(uri.host)
	puts(uri.port)
	key = "?key=#{APIkey}"
	puts(uri.path+key)
	request = Net::HTTP::Put.new(uri.path+key)
	request.set_form_data(myHash)
	http.request(request)
	puts(http.request(request))
end

updateCustomer('5516c07ba520e0066c9ac53b', json)
getCustomer('5516c07ba520e0066c9ac53b')

#DELETE requests

#delete a bill by id from a given account
def deleteBill(accID, billID)
	url = "http://api.reimaginebanking.com:80/accounts/#{accID}/bills/#{billID}?key=#{APIkey}"
	http = Net::HTTP.new(url.host, url.port)
	req = Net::HTTP::Delete.new(url.path)
	res = http.request(req)
end



def setAPIKey(key)
#	APIkey = key
end

def getAPIKey
	return APIkey
end


