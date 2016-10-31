<%@ Page Language="C#" AutoEventWireup="true" EnableViewState="false" CodeFile="profile-edit.aspx.cs" Inherits="home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Profile Page - Edit Editor</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" type="text/css" href="../css/custom.css"/>
<link rel="stylesheet" type="text/css" href="../css/bootstrap.css"/>
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
   <script src="../js/jquery-ui.min.js"></script>
    <link href="../js/jquery-ui.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css"/>
<!--custom scroller-->
    <link rel="stylesheet" type="text/css" href="customscroller/jquery.mCustomScrollbar.css" media="screen" />
	<script>window.jQuery || document.write('<script src="customscroller/jquery-1.11.0.min.js"><\/script>')</script>
	<script src="customscroller/jquery.mCustomScrollbar.concat.min.js"></script>
	<script>
		(function(jQuery){
			jQuery(window).load(function(){
				
				jQuery("#content-1").mCustomScrollbar({
					theme:"minimal"
				});
				
			});
		})(jQuery);
	</script>
   
    
</head>

<body>
<form runat="server" id="frmBrands">
      <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true">
                        </asp:ScriptManager>
    <div class="wrapper">
<!--Header-->
    <div class="headerbgm">
           <nav class="navbar navbar-default">
        <div class="container-fluid">
          <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
              <span class="sr-only"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
            <div style="margin-top:15px;">
              <div class="logob"><a href="../Default.aspx">Press Preview</a></div>
              <div class="logos"><a href="../Default.aspx">Logo Branding</a></div>
            </div>  
          </div>
          <div id="navbar" class="navbar-collapse collapse">
            <!--#INCLUDE FILE="../includes/messgTop.txt" -->            
         <div class="col-md-2">   
           
         </div>   
                       
            <ul class="nav navbar-nav" id="firstbb">
              <li><a href="Default.aspx">Activity</a></li>
              <li><a href="discover.aspx">Discover</a></li>
              <li><a href="brands.aspx">Brands</a></li>
              <li><a href="#">Inbox</a></li>
              <li><a href="#">Create</a></li>
            </ul>            
             <!--#INCLUDE FILE="../includes/settings.txt" -->   
          </div><!--/.nav-collapse -->
        </div><!--/.container-fluid -->
      </nav>

    </div><!--header bg-->
<!--Headerend-->
<!--text-->
<div class="wrapperblockedit">
    <!--Banner-->
     <!--#INCLUDE FILE="../includes/banner.txt" --> 
    <!--bannerend-->
     
  <div class="remainblock">
          
              <ul class="nav navbar-nav replaimg">
              <li class="dropdown replaimg" style="margin-bottom: -40px;">
                  <a href="" style="background-color:transparent; border-color:transparent;" class="dropdown-toggle" data-toggle="dropdown" role="button">
                      <img id="img_cover" src="../images/replaceimage.png" /></a>
                  <ul class="dropdown-menu" style="background-color:#808080;margin-left: 20px;margin-right: 20px;">
                      <li><input id="uploadBtn2" type="file" class="replaimg" style="padding:5px;" /></li>
                  </ul>
              </li>

          </ul>
         
      <div class="lines"><hr /></div>
          <div class="replaimg"><a href=""><img id="img_profile" src="../images/follo.png"/ class="img-responsive img-circle" ></a></div>
           <ul class="nav navbar-nav replaimg">
              <li class="dropdown replaimg" style="margin-bottom: -40px;">
                   <a href="" style="background-color:transparent; border-color:transparent;" class="dropdown-toggle" data-toggle="dropdown" role="button"><img  src="../images/replaceimage1.png"/></a>
                  <ul class="dropdown-menu" style="background-color:#808080;margin-left: 20px;margin-right: 20px;">
                      <li><input id="inputFile" type="file" class="replaimg" style="padding:5px;" /></li>
                  </ul>
              </li>

          </ul>
        
          <div class="lines"><hr /></div>
          
          <div class="likeblock">
              <div class="lineimage"><img src="../images/additemline.jpg" /></div>
              <div class="lineimage1"><img src="../images/sminsta.jpg" /></div>
              <div class="resmalltext">instagram</div>
              <div class="lreikebutton"><a href=""><a href=""><button type="submit" onclick="addmoreim()" name="addmore" id="addmore" class="hvr-sweep-to-rightre">Link</button></a></a></div>
              <div class="relinw"></div>
          </div><!--likeblock-->
          
          <div class="likeblock">
              <div class="lineimage"><img src="../images/additemline.jpg" /></div>
              <div class="lineimage1"><img src="../images/sminsta.jpg" /></div>
              <div class="resmalltext">twitter</div>
              <div class="lreikebutton"><a href=""><button type="submit" onclick="addmoreim()" name="addmore" id="addmore" class="hvr-sweep-to-rightre">Link</button></a></div>
              <div class="relinw"></div>
          </div><!--likeblock-->
          
          <div class="likeblock">
              <div class="lineimage"><img src="../images/additemline.jpg" /></div>
              <div class="lineimage1"><img src="../images/sminsta.jpg" /></div>
              <div class="resmalltext">facebook</div>
              <div class="lreikebutton"><a href=""><button type="submit" onclick="addmoreim()" name="addmore" id="addmore" class="hvr-sweep-to-rightre">Link</button></a></div>
              <div class="relinw"></div>
          </div><!--likeblock-->
          
          <div class="likeblock">
              <div class="lineimage"><img src="../images/additemline.jpg" /></div>
              <div class="lineimage1"><img src="../images/sminsta.jpg" /></div>
              <div class="resmalltext">youtube</div>
              <div class="lreikebutton"><a href=""><button type="submit" onclick="addmoreim()" name="addmore" id="addmore" class="hvr-sweep-to-rightre">Link</button></a></div>
              <div class="relinw"></div>
          </div><!--likeblock-->
          
          <div class="likeblock">
              <div class="lineimage"><img src="../images/additemline.jpg" /></div>
              <div class="lineimage1"><img src="../images/sminsta.jpg" /></div>
              <div class="resmalltext">pinterest</div>
              <div class="lreikebutton"><a href=""><button type="submit" onclick="addmoreim()" name="addmore" id="addmore" class="hvr-sweep-to-rightre">Link</button></a></div>
              <div class="relinw"></div>
          </div><!--likeblock-->
          
          <div class="likeblock">
              <div class="lineimage"><img src="../images/additemline.jpg" /></div>
              <div class="reinput"><input class="seinre" placeholder="Enter Username" /></div>
              <div class="resubtext"><a href="">Submit</a></div>
              <div class="recross"><a href=""><img src="../images/smcross.jpg" /></a></div>
          </div><!--likeblock-->
          
          
     </div><!--col-md-3 col-xs-12-->
   
   <div class="remainblock1">
      <div class="wrapreblock">
      
      <div class="reblockadd">
        <div class="textforget">Basic Editor Information</div>     
      </div>
      <div class="col-md-12">
          <div id="divAlerts" runat="server" class="alert" visible="False">
              <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
              <asp:Label runat="server" ID="lblStatus" for="PageMessage"
                  Text="" Visible="True"></asp:Label>
          </div>
      </div>
    
      <div class="col-md-6 col-xs-12 " ><input type="text" name="fname" id="fname" placeholder="First Name" class="logineb" /></div> 
      <div class="col-md-6 col-xs-12 " ><input type="text" name="lname" id="lname" placeholder="Last Name" class="logineb" /></div>  
    
      <div class="col-md-6 col-xs-12 " ><input type="text" name="org" id="org" placeholder="Organization" class="logineb" /></div> 
      <div class="col-md-6 col-xs-12 " ><input type="text" name="desig" id="desig" placeholder="Designation" class="logineb" /></div>
      
      <div class="relinw"></div>  
      
      <div class="reblockadd">
        <div class="textforget">About</div>     
      </div>
      
      <div class="reblockadd1">
       <div class="col-md-12" ><textarea name="text2" id="text2" placeholder="Brand History " class="loginebd"></textarea></div>   
      </div>
      
      <div class="relinw"></div> 
      
      <div class="reblockadd">
        <div class="textforget">Website URL</div>     
      </div> 
      
      
      <div class="rewebblock">
         <div class="reb1"><button type="submit" name="login" id="login" class="hvr-sweep-to-right3">Http://</button></div> 
         <div class="reb2"><input type="text" name="search" id="search" placeholder="" value="" class="sein2" /></div>   
      </div>
      
      <div class="relinw"></div>
      
      
      <div class="reblockadd">
        <div class="textforget">Location</div>     
      </div> 
      
    <div class="reblockadd1">
       <div class="col-md-12" ><input type="text" name="add1" id="add1" placeholder="Address 1" class="logineb" /></div>   
    </div>
    
    <div class="reblockadd1">
       <div class="col-md-12" ><input type="text" name="add2" id="add2" placeholder="Address 2 Optional" class="logineb" /></div>   
    </div>
    
      <div class="col-md-6 col-xs-12 " ><select name="selectcountry" class="loginebs">
    <option value="00">Country</option>
	<option value="AF">Afghanistan</option>
	<option value="AX">Åland Islands</option>
	<option value="AL">Albania</option>
	<option value="DZ">Algeria</option>
	<option value="AS">American Samoa</option>
	<option value="AD">Andorra</option>
	<option value="AO">Angola</option>
	<option value="AI">Anguilla</option>
	<option value="AQ">Antarctica</option>
	<option value="AG">Antigua and Barbuda</option>
	<option value="AR">Argentina</option>
	<option value="AM">Armenia</option>
	<option value="AW">Aruba</option>
	<option value="AU">Australia</option>
	<option value="AT">Austria</option>
	<option value="AZ">Azerbaijan</option>
	<option value="BS">Bahamas</option>
	<option value="BH">Bahrain</option>
	<option value="BD">Bangladesh</option>
	<option value="BB">Barbados</option>
	<option value="BY">Belarus</option>
	<option value="BE">Belgium</option>
	<option value="BZ">Belize</option>
	<option value="BJ">Benin</option>
	<option value="BM">Bermuda</option>
	<option value="BT">Bhutan</option>
	<option value="BO">Bolivia, Plurinational State of</option>
	<option value="BQ">Bonaire, Sint Eustatius and Saba</option>
	<option value="BA">Bosnia and Herzegovina</option>
	<option value="BW">Botswana</option>
	<option value="BV">Bouvet Island</option>
	<option value="BR">Brazil</option>
	<option value="IO">British Indian Ocean Territory</option>
	<option value="BN">Brunei Darussalam</option>
	<option value="BG">Bulgaria</option>
	<option value="BF">Burkina Faso</option>
	<option value="BI">Burundi</option>
	<option value="KH">Cambodia</option>
	<option value="CM">Cameroon</option>
	<option value="CA">Canada</option>
	<option value="CV">Cape Verde</option>
	<option value="KY">Cayman Islands</option>
	<option value="CF">Central African Republic</option>
	<option value="TD">Chad</option>
	<option value="CL">Chile</option>
	<option value="CN">China</option>
	<option value="CX">Christmas Island</option>
	<option value="CC">Cocos (Keeling) Islands</option>
	<option value="CO">Colombia</option>
	<option value="KM">Comoros</option>
	<option value="CG">Congo</option>
	<option value="CD">Congo, the Democratic Republic of the</option>
	<option value="CK">Cook Islands</option>
	<option value="CR">Costa Rica</option>
	<option value="CI">Côte d'Ivoire</option>
	<option value="HR">Croatia</option>
	<option value="CU">Cuba</option>
	<option value="CW">Curaçao</option>
	<option value="CY">Cyprus</option>
	<option value="CZ">Czech Republic</option>
	<option value="DK">Denmark</option>
	<option value="DJ">Djibouti</option>
	<option value="DM">Dominica</option>
	<option value="DO">Dominican Republic</option>
	<option value="EC">Ecuador</option>
	<option value="EG">Egypt</option>
	<option value="SV">El Salvador</option>
	<option value="GQ">Equatorial Guinea</option>
	<option value="ER">Eritrea</option>
	<option value="EE">Estonia</option>
	<option value="ET">Ethiopia</option>
	<option value="FK">Falkland Islands (Malvinas)</option>
	<option value="FO">Faroe Islands</option>
	<option value="FJ">Fiji</option>
	<option value="FI">Finland</option>
	<option value="FR">France</option>
	<option value="GF">French Guiana</option>
	<option value="PF">French Polynesia</option>
	<option value="TF">French Southern Territories</option>
	<option value="GA">Gabon</option>
	<option value="GM">Gambia</option>
	<option value="GE">Georgia</option>
	<option value="DE">Germany</option>
	<option value="GH">Ghana</option>
	<option value="GI">Gibraltar</option>
	<option value="GR">Greece</option>
	<option value="GL">Greenland</option>
	<option value="GD">Grenada</option>
	<option value="GP">Guadeloupe</option>
	<option value="GU">Guam</option>
	<option value="GT">Guatemala</option>
	<option value="GG">Guernsey</option>
	<option value="GN">Guinea</option>
	<option value="GW">Guinea-Bissau</option>
	<option value="GY">Guyana</option>
	<option value="HT">Haiti</option>
	<option value="HM">Heard Island and McDonald Islands</option>
	<option value="VA">Holy See (Vatican City State)</option>
	<option value="HN">Honduras</option>
	<option value="HK">Hong Kong</option>
	<option value="HU">Hungary</option>
	<option value="IS">Iceland</option>
	<option value="IN">India</option>
	<option value="ID">Indonesia</option>
	<option value="IR">Iran, Islamic Republic of</option>
	<option value="IQ">Iraq</option>
	<option value="IE">Ireland</option>
	<option value="IM">Isle of Man</option>
	<option value="IL">Israel</option>
	<option value="IT">Italy</option>
	<option value="JM">Jamaica</option>
	<option value="JP">Japan</option>
	<option value="JE">Jersey</option>
	<option value="JO">Jordan</option>
	<option value="KZ">Kazakhstan</option>
	<option value="KE">Kenya</option>
	<option value="KI">Kiribati</option>
	<option value="KP">Korea, Democratic People's Republic of</option>
	<option value="KR">Korea, Republic of</option>
	<option value="KW">Kuwait</option>
	<option value="KG">Kyrgyzstan</option>
	<option value="LA">Lao People's Democratic Republic</option>
	<option value="LV">Latvia</option>
	<option value="LB">Lebanon</option>
	<option value="LS">Lesotho</option>
	<option value="LR">Liberia</option>
	<option value="LY">Libya</option>
	<option value="LI">Liechtenstein</option>
	<option value="LT">Lithuania</option>
	<option value="LU">Luxembourg</option>
	<option value="MO">Macao</option>
	<option value="MK">Macedonia, the former Yugoslav Republic of</option>
	<option value="MG">Madagascar</option>
	<option value="MW">Malawi</option>
	<option value="MY">Malaysia</option>
	<option value="MV">Maldives</option>
	<option value="ML">Mali</option>
	<option value="MT">Malta</option>
	<option value="MH">Marshall Islands</option>
	<option value="MQ">Martinique</option>
	<option value="MR">Mauritania</option>
	<option value="MU">Mauritius</option>
	<option value="YT">Mayotte</option>
	<option value="MX">Mexico</option>
	<option value="FM">Micronesia, Federated States of</option>
	<option value="MD">Moldova, Republic of</option>
	<option value="MC">Monaco</option>
	<option value="MN">Mongolia</option>
	<option value="ME">Montenegro</option>
	<option value="MS">Montserrat</option>
	<option value="MA">Morocco</option>
	<option value="MZ">Mozambique</option>
	<option value="MM">Myanmar</option>
	<option value="NA">Namibia</option>
	<option value="NR">Nauru</option>
	<option value="NP">Nepal</option>
	<option value="NL">Netherlands</option>
	<option value="NC">New Caledonia</option>
	<option value="NZ">New Zealand</option>
	<option value="NI">Nicaragua</option>
	<option value="NE">Niger</option>
	<option value="NG">Nigeria</option>
	<option value="NU">Niue</option>
	<option value="NF">Norfolk Island</option>
	<option value="MP">Northern Mariana Islands</option>
	<option value="NO">Norway</option>
	<option value="OM">Oman</option>
	<option value="PK">Pakistan</option>
	<option value="PW">Palau</option>
	<option value="PS">Palestinian Territory, Occupied</option>
	<option value="PA">Panama</option>
	<option value="PG">Papua New Guinea</option>
	<option value="PY">Paraguay</option>
	<option value="PE">Peru</option>
	<option value="PH">Philippines</option>
	<option value="PN">Pitcairn</option>
	<option value="PL">Poland</option>
	<option value="PT">Portugal</option>
	<option value="PR">Puerto Rico</option>
	<option value="QA">Qatar</option>
	<option value="RE">Réunion</option>
	<option value="RO">Romania</option>
	<option value="RU">Russian Federation</option>
	<option value="RW">Rwanda</option>
	<option value="BL">Saint Barthélemy</option>
	<option value="SH">Saint Helena, Ascension and Tristan da Cunha</option>
	<option value="KN">Saint Kitts and Nevis</option>
	<option value="LC">Saint Lucia</option>
	<option value="MF">Saint Martin (French part)</option>
	<option value="PM">Saint Pierre and Miquelon</option>
	<option value="VC">Saint Vincent and the Grenadines</option>
	<option value="WS">Samoa</option>
	<option value="SM">San Marino</option>
	<option value="ST">Sao Tome and Principe</option>
	<option value="SA">Saudi Arabia</option>
	<option value="SN">Senegal</option>
	<option value="RS">Serbia</option>
	<option value="SC">Seychelles</option>
	<option value="SL">Sierra Leone</option>
	<option value="SG">Singapore</option>
	<option value="SX">Sint Maarten (Dutch part)</option>
	<option value="SK">Slovakia</option>
	<option value="SI">Slovenia</option>
	<option value="SB">Solomon Islands</option>
	<option value="SO">Somalia</option>
	<option value="ZA">South Africa</option>
	<option value="GS">South Georgia and the South Sandwich Islands</option>
	<option value="SS">South Sudan</option>
	<option value="ES">Spain</option>
	<option value="LK">Sri Lanka</option>
	<option value="SD">Sudan</option>
	<option value="SR">Suriname</option>
	<option value="SJ">Svalbard and Jan Mayen</option>
	<option value="SZ">Swaziland</option>
	<option value="SE">Sweden</option>
	<option value="CH">Switzerland</option>
	<option value="SY">Syrian Arab Republic</option>
	<option value="TW">Taiwan, Province of China</option>
	<option value="TJ">Tajikistan</option>
	<option value="TZ">Tanzania, United Republic of</option>
	<option value="TH">Thailand</option>
	<option value="TL">Timor-Leste</option>
	<option value="TG">Togo</option>
	<option value="TK">Tokelau</option>
	<option value="TO">Tonga</option>
	<option value="TT">Trinidad and Tobago</option>
	<option value="TN">Tunisia</option>
	<option value="TR">Turkey</option>
	<option value="TM">Turkmenistan</option>
	<option value="TC">Turks and Caicos Islands</option>
	<option value="TV">Tuvalu</option>
	<option value="UG">Uganda</option>
	<option value="UA">Ukraine</option>
	<option value="AE">United Arab Emirates</option>
	<option value="GB">United Kingdom</option>
	<option value="US">United States</option>
	<option value="UM">United States Minor Outlying Islands</option>
	<option value="UY">Uruguay</option>
	<option value="UZ">Uzbekistan</option>
	<option value="VU">Vanuatu</option>
	<option value="VE">Venezuela, Bolivarian Republic of</option>
	<option value="VN">Viet Nam</option>
	<option value="VG">Virgin Islands, British</option>
	<option value="VI">Virgin Islands, U.S.</option>
	<option value="WF">Wallis and Futuna</option>
	<option value="EH">Western Sahara</option>
	<option value="YE">Yemen</option>
	<option value="ZM">Zambia</option>
	<option value="ZW">Zimbabwe</option>                         </select>
    </div> 
      <div class="col-md-6 col-xs-12 " ><input type="text" name="state" id="state" placeholder="State/Province" class="logineb" /></div>
      
      <div class="col-md-6 col-xs-12 " ><input type="text" name="city" id="city" placeholder="City" class="logineb" /></div> 
      <div class="col-md-6 col-xs-12 " ><input type="text" name="zip" id="zip" placeholder="zip/Postal Code" class="logineb" /></div>
      
      <div class="col-md-6 col-xs-12 " ><input type="text" name="phone" id="phone" placeholder="Phone Number" class="logineb" /></div> 
      <div class="col-md-6 col-xs-12 " ><input type="text" name="email" id="email" placeholder="Email Address" class="logineb" /></div>
      
      <div class="relinw"></div>
      
      <div class="reblockadd1">
            <div class="col-md-12" style="margin:auto; float:left; text-align:right;">
                <button type="submit" name="signup" id="signup" class="hvr-sweep-to-right1">Submit</button>                     
            </div> <!-- col-md-6-->
      </div>

    
    
   </div></div><!--col-md-10 col-sm-12 col-xs-12--> 
    
</div><!--wrapperblock-->
<!--text-->  
<!--footer-->
  <div class="footerbg">
     <div class="row">
       <div class="col-md-11 col-xs-10">©<%: DateTime.Now.Year %> Press Preview</div>
        <div class="col-md-pull-1 col-xs-pull-1">
           <div class="f1"><a id="loaddata"><img src="../images/footerarrow.png" /></a></div>
           <div class="f2"><a id="loaddatan">Expand>/div>
        
      </div>    
  </div><!--footer-->
<!--footer-->

</div><!--wrapper-->

<script src="../js/bootstrap.js"></script>
       <script type="text/javascript">
        function readURL(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();

                reader.onload = function (e) {
                    $('#img_profile').attr('src', e.target.result);
                }

                reader.readAsDataURL(input.files[0]);
            }
        }

        $("#inputFile").change(function () {
            readURL(this);
        });
    </script>
</form>

</body>
</html>
