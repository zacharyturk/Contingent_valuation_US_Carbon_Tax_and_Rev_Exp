/*This code is in support of a contingent valuation study conducted by Zachary Turk,
Matthew Kotchen, and Anthony Leiserowitz at Yale University School of Forestry & Environmental
Studies in 2016.
*/
*Loading the data:
pwd
cd "C:\Users\Zachary\Documents\Contingent valuation project Turk Kotchen Leiserowitz 2016\"
use CVData.dta,clear
save Contingent_valuation_data_Turk_Kotchen_Leiserowitz_2016.dta, replace
*
use Contingent_valuation_data_Turk_Kotchen_Leiserowitz_2016.dta, clear
/*
foreach i of varlist *{
foreach var of varlist * {
rename `i' `=lower("`i'")'
}
*/
*Setting sampling weights provided:
svyset, clear
svyset caseid [weight=weight]
/*Data provided as SPSS file and formatted through R for use in Stata.  As such, data check digits 
provided to check integrity.  For question x65 the following is provided as the correct weighted results:
	Frequency	Percent	Cumulative Percent
Yes		859		70.1	70.1
No		155		12.6	82.7
Don’t know212	17.3	100.0
Total	1226	100.0	100.0
Checking the data in Stata: 
svy: tab x65
*/
*Note:
*help svy estimation
*
*Cleaning the data:
*Dropping empty columns:
drop dov_xc dov_xd dov_xe dov_xf dov_xg dov_xh dov_xi dov_xj dov_xk dov_xl dov_xm dov_xn
drop x14570 x14571 x14572 x14573 x14574 x14575 x14576 x14577 x14578 x14579 x1457l x1457m
drop dov_x1 dov_x2 dov_x3 dov_x4 dov_x5 dov_x6 dov_x7 dov_x8 dov_x9 dov_xa dov_xb
drop x140a0 x140a1 x140a2 x140a3 x140a4 x140a5 x140a6 x140a7 x140a8 x140a9 x140aa x140ab
*Labeling the data set:
la da "2016 Contingent valuation survey data"
*Labeling variables:
la var x22 "Do you think global warming is a bad thing or a good thing?"
la var x65 "Do you think that global warming is happening?"
la var x66a "How sure are you that global warming is happening?"
la var x66b "How sure are you that global warming is not happening?"
la var x1103b "How much do you support CO2 limits on power plants?"
la var x1456 "*Do you prefer to regulate, tax, both, or neither on pollution?"
*la var dov_x1456 "This identifies the order x1456 were presented"
la var x1457a "*Tax on fos fuels yes/no: Reduce Federal income taxes"
la var x1457b "*Tax on fos fuels yes/no: Reduce Federal payroll taxes"
la var x1457c "*Tax on fos fuels yes/no: Reduce corporate taxes"
la var x1457d "*Tax on fos fuels yes/no: Pay down the national debt"
la var x1457e "*Tax on fos fuels yes/no: Return the money to all American households in equal amounts"
la var x1457f "*Tax on fos fuels yes/no: Assist workers in the coal industry that may lose their jobs as a result of the tax"
la var x1457g "*Tax on fos fuels yes/no: Assist low-income communities that are most vulnerable to the impacts of global warming"
la var x1457h "*Tax on fos fuels yes/no: Support the development of clean energy (solar, wind)"
la var x1457i "*Tax on fos fuels yes/no: Fund improvements to America’s infrastructure"
la var x1457j "*Tax on fos fuels yes/no: Fund programs to help American communities prepare for and adapt to global warming"
la var x1457k "*Tax on fos fuels yes/no: Other (please specify)"
la var x1457k_text "text for Tax on fos fuels other please specify"
*la var dov_x1457a_x1457k "This identifies the order X1457a-k presented"
*la var dov_x0 "This is a constant in the data"
la var x1457a_p "*Pct fos fuel tax to: Reduce Federal income taxes"
la var x1457b_p "*Pct fos fuel tax to: Reduce Federal payroll taxes "
la var x1457c_p "*Pct fos fuel tax to: Reduce corporate taxes"
la var x1457d_p "*Pct fos fuel tax to: Pay down the national debt"
la var x1457e_p "*Pct fos fuel tax to: Return the money to all American households in equal amounts"
la var x1457f_p "*Pct fos fuel tax to: Assist workers in the coal industry that may lose their jobs as a result of the tax"
la var x1457g_p "*Pct fos fuel tax to: Assist low-income communities that are most vulnerable to the impacts of global warming."
la var x1457h_p "*Pct fos fuel tax to: Support the development of clean energy (solar, wind)"
la var x1457i_p "*Pct fos fuel tax to: Fund improvements to America’s infrastructure "
la var x1457j_p "*Pct fos fuel tax to: Fund programs to help American communities prepare for and adapt to global warming"
la var x1457k_p "*Pct fos fuel tax to: Other (text box presented)"
la var x1457a_p_x1457k_p_total "Presents whether x1457a-k_p total 100% or 0%"
la var x788a "*Tax on fos fuels to reduce g warming, support/oppose"
la var dov_x788a "*Bid amount presented, support/oppose"
la var x140 "Generally speaking, do you think of yourself as:"
la var x140a "Other (text response) to previous"
la var x141 "Do you think of yourself as closer to the:"
la var x585 "Do you consider yourself part of the Tea Party movement, or not?"
la var x142 "In general, do you think of yourself as"
la var x145_16p5 "Did you vote in the 2016 national election that was held in November, or did you not vote?"
la var ppage "Age"
la var ppagecat "Age cat 7"
la var ppagect4 "Ave cat 4"
la var ppeduc "Education level"
la var ppeducat "Education cat"
la var ppethm "Ethnicity"
la var ppgender "Gender"
la var pphhhead "Head of household?"
la var pphhsize "Household size"
la var pphouse "Home type"
la var ppincimp "Household income"
la var ppmarit "Marital status"
la var ppmsacat "Metro/non-metro"
la var ppreg4 "Region cat 4"
la var ppreg9 "Region cat 9"
la var pprent "Rent or own?"
la var ppstaten "State"
la var ppt01 "Total number of HH members age 1 or younger"
la var ppt25 "Total number of HH members age 2 to 5"
la var ppt612 "Total number of HH members age 6 to 12"
la var ppt1317 "Total number of HH members age 13 to 17"
la var ppt18ov "Total number of HH members age 18 or older"
la var ppwork "Job status"
*Checking correlation and then dropping the ordering check variables, 
* dov_x1457a_x1457k in particular makes inspecting the data more difficult:
corr x1456 dov_x1456
drop dov_x1456
corr x1457a x1457b x1457c x1457d x1457e x1457f x1457g x1457h x1457i x1457j x1457k dov_x1457a_x1457k
drop dov_x1457a_x1457k
*Dropping a few others:
drop dov_x0
*Renaming:
rename (caseid weight x22 x65 x66a x66b x1103b x1456 /*dov_x1456*/ x1457a x1457b x1457c ///
x1457d x1457e x1457f x1457g x1457h x1457i x1457j x1457k x1457k_text /*dov_x1457a_x1457k*/ ///
/*dov_x0*/ x1457a_p x1457b_p x1457c_p x1457d_p x1457e_p x1457f_p x1457g_p x1457h_p x1457i_p ///
x1457j_p x1457k_p x1457a_p_x1457k_p_total x788a dov_x788a x140 x140a x141 x585 x142 ///
x145_16p5 ppage ppagecat ppagect4 ppeduc ppeducat ppethm ppgender pphhhead pphhsize ///
pphouse ppincimp ppmarit ppmsacat ppreg4 ppreg9 pprent ppstaten ppt01 ppt25 ppt612 ///
ppt1317 ppt18ov ppwork) ///
(caseid weight gwarming_goodbad gwarming_happening gwarm_cert_hap gwarm_cert_nothap emission_limits reg_or_tax /*dov_x1456*/ taxuse_a taxuse_b taxuse_c ///
taxuse_d taxuse_e taxuse_f taxuse_g taxuse_h taxuse_i taxuse_j taxuse_k taxuse_k_text /*dov_x1457a_x1457k*/ ///
/*dov_x0*/ taxpct_a_p taxpct_b_p taxpct_c_p taxpct_d_p taxpct_e_p taxpct_f_p taxpct_g_p taxpct_h_p taxpct_i_p ///
taxpct_j_p taxpct_k_p taxpct_total x788a bid polparty polparty_text polparty_alt teaparty pol_leaning ///
voted age age_cat1 age_cat2 educ educ_cat ethnicity gender head_household household_size ///
hometype income marital_stat metro region_4 region_9 rent_own state hh_under1 hh_2to5 hh_6to12 ///
hh_13to17 hh_over18 work_status)
*Decoding states:
decode state, generate(State)
drop state
*Inspecting contents of all variables:
foreach i of varlist *{
tab `i'
}
*Adding in additional political affiliation data from the survey:
merge 1:1 caseid using AddlCVData.dta
drop _merge
rename x143a voter_registration
*
*First regression preparation:
recode x788a (1=.) (2=1) (3=0), gen(bid_result)
tab bid_result
recode bid (1=5) (2=25) (3=45) (4=45) (5=65) (6=65) (7=85) (8=85) (9=105) (10=105) (11=135) (12=155)
_strip_labels bid
*rescaling education:
recode educ (3=0) (4=1) (5=5) (6=7) (7=9) (8=10) (9=11) (10=11) (11=12) (12=12) (13=14) (14=16) (15=18) (16=21), gen(educyears)
*In case want to rescale education (no effect on results)
*recode educ (3=1) (4=2) (5=3) (6=4) (7=5) (8=6) (9=7) (10=8) (11=9) (12=10) (13=11) (14=12) (15=13) (16=14), gen(n_educ)
*tab n_educ
recode gender (3=1) (4=0), gen(male)
tab age 
tab income
tab income, nol
tab household_size
recode ethnicity (3=1) (4=0) (5=0) (6=0) (7=0), gen(white)
*
recode income (3=0) (4=5000) (5=7500) (6=10000) (7=12500) (8=15000) (9=20000) ///
(10=25000) (11=30000) (12=35000) (13=40000) (14=50000) (15=60000) (16=75000) (17=85000) ///
(18=100000) (19=125000) (20=150000) (21=175000) (22=200000) (23=250000), gen(income_censored)
replace income_censored=(income_censored/10000)
*
g gwarming_verysure=0
replace gwarming_verysure=1 if gwarm_cert_hap==4 | gwarm_cert_hap==5
g gwarming_verysure_not=0
replace gwarming_verysure_not=1 if gwarm_cert_nothap==4 | gwarm_cert_nothap==5
*
*svy: logit bid_result bid educ male household_size income age white ib(3).polparty if polparty!=1
*svy: logit bid_result bid educ male household_size income age white ib(3).partywleaners if partywleaners!=1
g republican=0 if partywleaners!=1
replace republican=1 if partywleaners==2
g democrat=0 if partywleaners!=1
replace democrat=1 if partywleaners==3
g independent=0 if partywleaners!=1
replace independent=1 if partywleaners==4
g noparty=0 if partywleaners!=1
replace noparty=1 if partywleaners==5
*leave democrat as baseline and use these: republican independent noparty
g globalwarming_yes=0
replace globalwarming_yes=1 if gwarming_happening==2
g globalwarming_no=0
replace globalwarming_no=1 if gwarming_happening==3
g globalwarming_dontknow=0
replace globalwarming_dontknow=1 if gwarming_happening==4
*leave don'tknow as baseline and use: globalwarming_no globalwarming_yes
*
*Logit regression models:
*model 1:
svy: logit bid_result bid educyears male household_size income_censored age white republican independent noparty
*outreg2 using "RESULTS logistic regression.doc", ctitle(model 1) replace
outreg2 using "RESULTS logistic regression.xls", ctitle(model 1) replace
mfx compute
outreg2 using "RESULTS logistic regression marginal effects.xls", mfx ctitle(model 1) replace
*model 2:
svy: logit bid_result bid educyears male household_size income_censored age white republican independent noparty globalwarming_no globalwarming_yes
*outreg2 using "RESULTS logistic regression.doc", ctitle(model 2) append
outreg2 using "RESULTS logistic regression.xls", ctitle(model 2) append
mfx compute
outreg2 using "RESULTS logistic regression marginal effects.xls", mfx ctitle(model 2) append
*model 3:
*This is the preferred model, saving it as a scalar for repeated use:
global preferred_spec bid_result bid educyears male household_size income_censored age white republican independent noparty globalwarming_no globalwarming_yes gwarming_verysure gwarming_verysure_not
svy: logit $preferred_spec
*svy: logit bid_result bid educyears male household_size income_censored age white republican independent noparty globalwarming_no globalwarming_yes gwarming_verysure gwarming_verysure_not
*outreg2 using "RESULTS logistic regression.doc", ctitle(model 3) append
outreg2 using "RESULTS logistic regression.xls", ctitle(model 3) append
mfx compute
outreg2 using "RESULTS logistic regression marginal effects.xls", mfx ctitle(model 3) append
*svy jack: logit bid_result bid educ male household_size income_censored age white ib(3).partywleaners ib(4).gwarming_happening gwarming_verysure gwarming_verysure_not if partywleaners!=1
*
*Retrieving pseudo-R2 measures from the non-svy specification should they be asked for:
di "Retrieving pseudo R2 from non-svy logit specifications:""
quietly logit bid_result bid educyears male household_size income_censored age white republican independent noparty
di "Model 1:" e(r2_p)
quietly logit bid_result bid educyears male household_size income_censored age white republican independent noparty globalwarming_no globalwarming_yes
di "Model 2:" e(r2_p)
quietly logit $preferred_spec 
di "Model 3:" e(r2_p)
/*
foreach i in a b c d e f g h i j k{
replace taxpct_`i'_p=0 if taxpct_`i'_p==.
}
*/
*Calculating the percent support and allotment of tax funds tables:
svy: mean taxpct_a_p if taxpct_total==100
matrix paystats=((e(N)/1226)*100, _b[taxpct_a_p], _se[taxpct_a_p])
foreach i in /*a*/ b c d e f g h i j k{
svy: mean taxpct_`i'_p if taxpct_total==100
matrix stats_`i'_p=((e(N)/1226)*100, _b[taxpct_`i'_p], _se[taxpct_`i'_p])
matrix paystats=paystats\stats_`i'_p
}
matrix colnames paystats= "% support" "mean % allotment" "std error allotment" 
matrix rownames paystats= "Reduce Federal income taxes" ///
"Reduce Federal payroll taxes" ///
"Reduce corporate taxes" ///
"Pay down the national debt" ///
"Return the money to households" ///
"Assist workers in coal industry" ///
"Assist communities impacted g w" ///
"Clean energy (solar, wind)" ///
"Improve infrastructure" ///
"Prepare for global warming" ///
"Other"
matrix list paystats
putexcel set RESULTS.xlsx, modify sheet("Tax Usage Prefs")
putexcel A1=matrix(paystats), names
*
*Calculating summary table:
svy: mean educyears
estat sd
matrix summarystats=(r(mean),r(sd),e(N))
foreach i in male household_size income_censored age white republican democrat independent noparty globalwarming_dontknow globalwarming_no globalwarming_yes{
svy: mean `i'
estat sd
matrix sum_`i'=(r(mean),r(sd),e(N))
matrix summarystats=summarystats\sum_`i'
}
svy: mean gwarming_verysure_not if globalwarming_no==1
estat sd
matrix sum_gwarming_verysure_not=(r(mean),r(sd),e(N))
matrix summarystats=summarystats\sum_gwarming_verysure_not
svy: mean gwarming_verysure if globalwarming_yes==1
estat sd
matrix sum_gwarming_verysure=(r(mean),r(sd),e(N))
matrix summarystats=summarystats\sum_gwarming_verysure
matrix colnames summarystats= "mean" "standard deviation" "observations"
matrix rownames summarystats= "Education (years)" ///
"Male (1=yes)" ///
"Household size (# people)" ///
"Income ($10,000's)" ///
"Age (years)" ///
"White (1=yes)" ///
"Republican (1=yes)" ///
"Democrat (1=yes)" ///
"Independent (1=yes)" ///
"No party (1=yes)" ///
"Global warming 'don't know'" ///
"Global warming 'no'" ///
"Global warming 'yes'" ///
"Global warming 'no, very sure'" ///
"Global warming 'yes, very sure'"
tab gwarming_verysure_not
tab gwarming_verysure
*Exporting summary stats w/ standard deviations:
matrix list summarystats
putexcel set RESULTS.xlsx, modify sheet("Summary Stats")
putexcel A1=matrix(summarystats), names
/*Alternate summary stats with standard errors:
svy: mean bid educyears male household_size income_censored age white republican democrat independent noparty globalwarming_dontknow globalwarming_no globalwarming_yes 
outreg2 using "RESULTS Summary Stats.doc", replace noaster noobs dec(2) keep(educyears male household_size income_censored age white republican democrat independent noparty globalwarming_dontknow globalwarming_no globalwarming_yes) 
svy: mean gwarming_verysure_not if globalwarming_no==1
outreg2 using "RESULTS Summary Stats.doc", append noaster noobs dec(2) 
svy: mean gwarming_verysure if globalwarming_yes==1
outreg2 using "RESULTS Summary Stats.doc", append noaster noobs dec(2)
*/
*Calculating percentage that support at each bid:
svy: mean bid_result if bid==5
matrix support=(_b[bid_result]*100,_se[bid_result]*100,e(N))
*estat sd
*matrix support=(r(mean),r(sd))
foreach i in 25 45 65 85 105 135 155{
svy: mean bid_result if bid==`i'
matrix support_`i'=(_b[bid_result]*100,_se[bid_result]*100,e(N))
*estat sd
*matrix support_`i'=(r(mean),r(sd))
matrix support=support\support_`i'
}
matrix colnames support= "percent support" "std error" "number"
matrix rownames support= "$5" "$25" "$45" "$65" "$85" "$105" "$135" "$155"
matrix list support
putexcel set RESULTS.xlsx, modify sheet("Support Stats")
putexcel A1=matrix(support), names
*
*Calculating WTP and confidence intervals for preferred specification using package wtpcikr:
*First make vector of svy weighted means to use:
svy: mean educyears
matrix svymeans=(_b[educyears])
foreach i in male household_size income_censored age white republican independent noparty globalwarming_no globalwarming_yes gwarming_verysure gwarming_verysure_not{
svy: mean `i'
matrix svymeans_`i'=(_b[`i'])
matrix svymeans=svymeans,svymeans_`i'
}
matrix rownames svymeans= "Mean"
matrix colnames svymeans= "educyears" ///
"male" ///
"household_size" ///
"income_censored" ///
"age" ///
"white" ///
"republican" ///
"independent" ///
"noparty" ///
"globalwarming_no" ///
"globalwarming_yes" ///
"gwarming_verysure" ///
"gwarming_verysure_not"
matrix list svymeans
*Now calculating WTP and CI's:
svy: logit $preferred_spec
*Do as 10,000 replications:
wtpcikr bid educyears male household_size income_censored age white republican independent noparty globalwarming_no globalwarming_yes gwarming_verysure gwarming_verysure_not, /*meanl*/ mymean(svymeans) reps(1000)
*wtpcikr bid educyears male household_size income_censored age white republican independent noparty globalwarming_no globalwarming_yes gwarming_verysure gwarming_verysure_not
putexcel set RESULTS.xlsx, modify sheet("WTP measures")
putexcel A1="Estimate Krinsky and Robb Confidence Intervals for Mean and Median Willingness to Pay (WTP)" ///
A2=rscalarnames B2=rscalars
*
*Calculating WTP manually per Hanemann (1989):
quietly: svy: mean bid educyears male household_size income_censored age white republican independent noparty globalwarming_no globalwarming_yes gwarming_verysure gwarming_verysure_not 
foreach i in educyears male household_size income_censored age white republican independent noparty globalwarming_no globalwarming_yes gwarming_verysure gwarming_verysure_not{
scalar s_`i'=_b[`i']
}
scalar alpha=0
quietly: svy: logit $preferred_spec
foreach i in educyears male household_size income_censored age white republican independent noparty globalwarming_no globalwarming_yes gwarming_verysure gwarming_verysure_not{
*di "alpha start:" alpha
*di "coefficient:" _b[`i']
*di "mean value:" s_`i'
*di "product:" (_b[`i']*s_`i')
scalar alpha=alpha+(_b[`i']*s_`i')
*di "new alpha:" alpha
*di "  "
}
scalar alpha=alpha+_b[_cons]
*di _b[bid]
*di alpha
*di (1/_b[bid])*ln(1+exp(alpha))
di "Willingness to pay calculated as alpha/beta from Hanemann (1989) when allowing for negative WTP (eqn 4 or 4'):"
di alpha/_b[bid]
scalar manualWTP=(alpha/_b[bid])
putexcel set RESULTS.xlsx, modify sheet("WTP measures")
putexcel A8="Estimating WTP manually from Hanemann (1989) when allowing for negative WTP (eqn 4 or 4')" ///
A9="alpha/_b[bid]" B9=manualWTP
*
*Calculating the Turnbull empirical distribution estimator using package turnbull:
turnbull bid bid_result
putexcel set RESULTS.xlsx, modify sheet("WTP measures")
putexcel A11="Turnbull Nonparametric Estimator for Williness to Pay per Carson et al (1994a,b) and Haab and McConnell (1997)" ///
A12=rscalarnames B12=rscalars
*
*Using spike package using Kristrom (1997):
*Gen whether have WTP at all by using general support/oppose policy question x1103B:
g wtp_at_all=0
replace wtp_at_all=1 if emission_limits==4 | emission_limits==5
spike wtp_at_all bid_result bid
putexcel set RESULTS.xlsx, modify sheet("WTP measures")
putexcel A17="Spike model for Williness to Pay per Kristrom (1997)" ///
A18=rscalarnames B18=rscalars ///
A19="See Stata output for add'l spike parameters."
*
*Generating some other summary stats for discussion:
foreach i in gwarming_happening gwarming_goodbad emission_limits reg_or_tax{
di " "
di "`i'"
tab `i'
}
graph pie, over(gwarming_happening)
graph pie if gwarming_goodbad!=1, over(gwarming_goodbad)
graph pie if emission_limits!=1, over(emission_limits)
graph pie if reg_or_tax!=1, over(reg_or_tax)
*graph pie if reg_or_tax==2 | reg_or_tax==3 | reg_or_tax==4, over(reg_or_tax)
*
/*
*Plotting margins:
svy: logistic bid_result bid educyears male household_size income_censored age white republican independent noparty globalwarming_no globalwarming_yes gwarming_verysure gwarming_verysure_not
eststo bid_prob_margins: margins, at(bid=(0(50)400)) post
marginsplot
*Alternative WTP packages:
*Using package WTP:
svy: logit bid_result bid educyears male household_size income_censored age white republican independent noparty globalwarming_no globalwarming_yes gwarming_verysure gwarming_verysure_not
wtp bid _cons educyears male household_size income_censored age white republican independent noparty globalwarming_no globalwarming_yes gwarming_verysure gwarming_verysure_not
svy: logit bid_result bid educyears male household_size income_censored age white republican independent noparty globalwarming_no globalwarming_yes gwarming_verysure gwarming_verysure_not
wtp bid _cons educyears male household_size income_censored age white republican independent noparty globalwarming_no globalwarming_yes gwarming_verysure gwarming_verysure_not, krinsky
*
*Using package singleb:
singleb bid bid_result educyears male household_size income_censored age white republican independent noparty globalwarming_no globalwarming_yes gwarming_verysure gwarming_verysure_not
*/


*
*Alternative model using bid as pct energy bill increase in each state:
save temp.dta, replace
*first import state energy bill data:
import excel "C:\Users\Zachary\Documents\Contingent valuation project Turk Kotchen Leiserowitz 2016\EIA residential energy consumption 2015 table5_a.xlsx", ///
sheet("Table 5A") cellrange(A3:E65) firstrow clear
do statetoregiongenerator.do
statastates, name(State)
replace region=3 if State=="DISTRICT OF COLUMBIA"
replace division=5 if State=="DISTRICT OF COLUMBIA"
drop if _merge==1
drop State NumberofCustomers AverageMonthlyConsumptionkWh AveragePricecentskWh state_fips _merge
rename state_abbrev State
rename AverageMonthlyBillDollarand StateAveEnergyBill
order State region division StateAveEnergyBill
save temp_ave_state_energy_bill.dta, replace
*
use temp.dta, clear
merge m:1 State using temp_ave_state_energy_bill.dta
drop _merge
g pct_bid=(bid/(12*StateAveEnergyBill))*100
*
svy: logit bid_result pct_bid educyears male household_size income_censored age white republican independent noparty globalwarming_no globalwarming_yes gwarming_verysure gwarming_verysure_not
*outreg2 using "RESULTS logistic regression.doc", ctitle(model pctbid) append
outreg2 using "RESULTS logistic regression.xls", ctitle(model pctbid) append
*
svy: logit bid_result pct_bid educyears male household_size income_censored age white republican independent noparty globalwarming_no globalwarming_yes
outreg2 using "RESULTS logistic regression.xls", ctitle(model pctbid) append
mfx compute
outreg2 using "RESULTS logistic regression marginal effects.xls", mfx ctitle(pctbid) append




*Adding multinomial logit of support for tax v. standard v. both:
svy: mlogit reg_or_tax educyears male household_size income_censored age white republican independent noparty globalwarming_no gwarming_verysure_not globalwarming_yes gwarming_verysure if reg_or_tax!=1, base(6)
outreg2 using "RESULTS multinomial logistic regression.xls", replace
*
svy: mlogit reg_or_tax educyears male household_size income_censored age white republican independent noparty globalwarming_no gwarming_verysure_not globalwarming_yes gwarming_verysure if reg_or_tax!=1 & reg_or_tax!=6, base(5)
outreg2 using "RESULTS multinomial logistic regression2.xls", replace

*
tab reg_or_tax
tab reg_or_tax, nol
*Assigning "Other" tax uses based on text, where possible:
g othertaxuse=""
tab taxuse_k_text
tostring taxuse_k_text, replace
decode taxuse_k_text, generate(othrec)
*
foreach i in taxuse_a taxuse_b taxuse_c taxuse_d taxuse_e taxuse_f taxuse_g taxuse_h taxuse_i taxuse_j taxuse_k{
decode `i', generate(alt_`i')
replace alt_`i'="1" if alt_`i'=="Yes"
replace alt_`i'="0" if alt_`i'=="No"
replace alt_`i'="." if alt_`i'=="Refused"
destring alt_`i', replace
}
foreach i in taxpct_a_p taxpct_b_p taxpct_c_p taxpct_d_p taxpct_e_p taxpct_f_p taxpct_g_p taxpct_h_p taxpct_i_p taxpct_j_p taxpct_k_p{
gen alt_`i'=`i'
}
foreach i in ///
"Fund education" ///
"fund schools" ///
"generate jobs" ///
"Give money to households to participate in using solar or electric energy" ///
"health problems related to fossil fuel usage" ///
"health care and drugs" ///
"healthcare assist" ///
"improve schools" ///
"Invest in inner cities" ///
"jobs" ///
"lower gas prises" ///
"Raise social security budget" ///
"reduce cost of tuition at public colleges" ///
"Refund it" ///
"S.S." ///
"School Funding" ///
"Schools" ///
"social security" ///
"SS cola increases" ///
"Tuition free college" ///
"tax credits for implementation of solar" ///
"Support the veterans"{
replace alt_taxuse_e=1 if othrec=="`i'"
replace alt_taxpct_e_p=alt_taxpct_e_p+alt_taxpct_k_p if othrec=="`i'"
replace alt_taxpct_k_p=. if othrec=="`i'"
}
foreach i in ///
"Reduce all income taxes to middle class people" ///
"Reduce cost of government" ///
"Taxes"{
replace alt_taxuse_a=1 if othrec=="`i'"
replace alt_taxpct_a_p=alt_taxpct_a_p+alt_taxpct_k_p if othrec=="`i'"
replace alt_taxpct_k_p=. if othrec=="`i'"
}
foreach i in ///
"poor people"{
replace alt_taxuse_g=1 if othrec=="`i'"
replace alt_taxpct_g_p=alt_taxpct_g_p+alt_taxpct_k_p if othrec=="`i'"
replace alt_taxpct_k_p=. if othrec=="`i'"
}
foreach i in ///
"fund more clean energy in businesses" ///
"help stop global warming" ///
"increase wind power research" ///
"Invest in alt energy" ///
"research" ///
"more investment in renewable energy" ///
"use for development of altenative resources" ///
"Usethemoneytobuildwindfarmsandgrantstpayforsolarenergyforlow-middlincomfamilies." ///
"support natural gas" ///
"Build nuclear power stations" ///
"Nuclear"{
replace alt_taxuse_h=1 if othrec=="`i'"
replace alt_taxpct_h_p=alt_taxpct_h_p+alt_taxpct_k_p if othrec=="`i'"
replace alt_taxpct_k_p=. if othrec=="`i'"
}
foreach i in ///
"Fund national rapid transit"{
replace alt_taxuse_i=1 if othrec=="`i'"
replace alt_taxpct_i_p=alt_taxpct_i_p+alt_taxpct_k_p if othrec=="`i'"
replace alt_taxpct_k_p=. if othrec=="`i'"
}
foreach i in ///
"Fund transitional education for workers in shifting energy related jobs" ///
"helpthepeoplewhoaredependentonfossilfuelswiththeincreaseincostsduetothetax" ///
"train displaced workers"{
replace alt_taxuse_f=1 if othrec=="`i'"
replace alt_taxpct_f_p=alt_taxpct_f_p+alt_taxpct_k_p if othrec=="`i'"
replace alt_taxpct_k_p=. if othrec=="`i'"
}
*Now calculating the percent support and allotment of tax fund alternative tables:
svy: mean alt_taxpct_a_p
matrix paystats=((e(N)/1226)*100, _b[alt_taxpct_a_p], _se[alt_taxpct_a_p])
foreach i in /*a*/ b c d e f g h i j k{
svy: mean alt_taxpct_`i'_p
matrix stats_`i'_p=((e(N)/1226)*100, _b[alt_taxpct_`i'_p], _se[alt_taxpct_`i'_p])
matrix paystats=paystats\stats_`i'_p
}
matrix colnames paystats= "% support" "mean % allotment" "std error allotment" 
matrix rownames paystats= "Reduce Federal income taxes" ///
"Reduce Federal payroll taxes" ///
"Reduce corporate taxes" ///
"Pay down the national debt" ///
"Return the money to households" ///
"Assist workers in coal industry" ///
"Assist communities impacted g w" ///
"Clean energy (solar, wind)" ///
"Improve infrastructure" ///
"Prepare for global warming" ///
"Other"
matrix list paystats
putexcel set RESULTS.xlsx, modify sheet("Alt Tax Usage Prefs")
putexcel A1=matrix(paystats), names
*
*
*Testing for model specification ability to predict WTP: 
*First predicting WTP by respondent:
*drop bidres bidhat
svy: logit bid_result bid educyears male household_size income_censored age white republican independent noparty globalwarming_no globalwarming_yes gwarming_verysure gwarming_verysure_not
predict bidhat,xb
g bidres=0
replace bidres=(bidhat-(_b[bid]*bid))/_b[bid]
drop bidhat
*Checking for percent of correct predictions WTP:
rename bidres predictedWTP
g correct=0
replace correct=1 if -bid>=predictedWTP & bid_result==1
replace correct=1 if -bid<=predictedWTP & bid_result==0
g _bid=-bid
*order predictedWTP _bid bid_result correct
su correct
*Implies predicted WTP corresponds to bid_result in ~75-percent of cases.
*As bids in terms of of household energy bill percentage increases vary substantially across the U.S., this may be a source of
*incorrect WTP predictions at the individual level.  A bid in terms of percentage increases may be more appropriate in the survey
*though would require careful consideration and/or additional data in constructing a mean WTP.
*
*Considering alternate specification that uses a certainty variable rather than "no, very sure" and "yes, very sure":
*Interpreting the coefficient on this specification around the other variables may be difficult, however.
g certainty=5
replace certainty=1 if gwarm_cert_nothap==5
replace certainty=2 if gwarm_cert_nothap==4
replace certainty=3 if gwarm_cert_nothap==3
replace certainty=4 if gwarm_cert_nothap==2
*5 for those neither believing in or not global warming
replace certainty=6 if gwarm_cert_hap==2
replace certainty=7 if gwarm_cert_hap==3
replace certainty=8 if gwarm_cert_hap==4
replace certainty=9 if gwarm_cert_hap==5
svy: logit bid_result bid educyears male household_size income_censored age white republican independent noparty globalwarming_no globalwarming_yes certainty
*
*Generate table of regulate or tax preferences:
svy: tab reg_or_tax if reg_or_tax!=1 


svy: logit bid_result bid educyears male household_size income_censored age white republican independent noparty globalwarming_no globalwarming_yes
mfx compute
svy: logit bid_result bid educyears male household_size income_censored age white republican independent noparty globalwarming_no globalwarming_yes




********
*
*
*
*
********


*New WTP numbers:
drop wtp_at_all 
svy: logit bid_result bid educyears male household_size income_censored age white republican independent noparty globalwarming_no globalwarming_yes
*svy: logit bid_result pct_bid educyears male household_size income_censored age white republican independent noparty globalwarming_no globalwarming_yes



svy: logit bid_result pct_bid educyears household_size age male income_censored white republican independent noparty globalwarming_no globalwarming_yes
mfx compute

*Calculating WTP and confidence intervals for preferred specification using package wtpcikr:
*First make vector of svy weighted means to use:
svy: mean educyears
matrix svymeans=(_b[educyears])
foreach i in male household_size income_censored age white republican independent noparty globalwarming_no globalwarming_yes{
svy: mean `i'
matrix svymeans_`i'=(_b[`i'])
matrix svymeans=svymeans,svymeans_`i'
}
matrix rownames svymeans= "Mean"
matrix colnames svymeans= "educyears" ///
"male" ///
"household_size" ///
"income_censored" ///
"age" ///
"white" ///
"republican" ///
"independent" ///
"noparty" ///
"globalwarming_no" ///
"globalwarming_yes"
matrix list svymeans
*Now calculating WTP and CI's:
svy: logit bid_result bid educyears male household_size income_censored age white republican independent noparty globalwarming_no globalwarming_yes
*Do as 10,000 replications:
wtpcikr bid educyears male household_size income_censored age white republican independent noparty globalwarming_no globalwarming_yes, /*meanl*/ mymean(svymeans) reps(1000)
*wtpcikr bid educyears male household_size income_censored age white republican independent noparty globalwarming_no globalwarming_yes gwarming_verysure gwarming_verysure_not
putexcel set RESULTS.xlsx, modify sheet("WTP measures")
putexcel A1="Estimate Krinsky and Robb Confidence Intervals for Mean and Median Willingness to Pay (WTP)" ///
A2=rscalarnames B2=rscalars
*


*Predicting success rates:
svy: logit bid_result bid educyears male household_size income_censored age white republican independent noparty globalwarming_no globalwarming_yes
predict predict_dollar, xb
replace predict_dollar=1 if predict_dollar>0.5
replace predict_dollar=0 if predict_dollar<=0.5
g correct_dollar=0
replace correct_dollar=1 if bid_result==predict_dollar
*
svy: logit bid_result pct_bid educyears male household_size income_censored age white republican independent noparty globalwarming_no globalwarming_yes
predict predict_pct, xb
replace predict_pct=1 if predict_pct>0.5
replace predict_pct=0 if predict_pct<=0.5
g correct_percent=0
replace correct_percent=1 if bid_result==predict_pct
*
su correct_dollar correct_percent
order predictedWTP _bid bid_result correct_dollar correct_percent
svy: mean correct_dollar correct_percent
*
*
*
*
*



*Calculating WTP manually per Hanemann (1989):
quietly: svy: mean bid educyears male household_size income_censored age white republican independent noparty globalwarming_no globalwarming_yes 
foreach i in educyears male household_size income_censored age white republican independent noparty globalwarming_no globalwarming_yes{
scalar s_`i'=_b[`i']
}
scalar alpha=0
svy: logit bid_result bid educyears male household_size income_censored age white republican independent noparty globalwarming_no globalwarming_yes
foreach i in educyears male household_size income_censored age white republican independent noparty globalwarming_no globalwarming_yes{
*di "alpha start:" alpha
*di "coefficient:" _b[`i']
*di "mean value:" s_`i'
*di "product:" (_b[`i']*s_`i')
scalar alpha=alpha+(_b[`i']*s_`i')
*di "new alpha:" alpha
*di "  "
}
scalar alpha=alpha+_b[_cons]
*di _b[bid]
*di alpha
*di (1/_b[bid])*ln(1+exp(alpha))
di "Willingness to pay calculated as alpha/beta from Hanemann (1989) when allowing for negative WTP (eqn 4 or 4'):"
di alpha/_b[bid]
scalar manualWTP=(alpha/_b[bid])
putexcel set RESULTS.xlsx, modify sheet("WTP measures")
putexcel A8="Estimating WTP manually from Hanemann (1989) when allowing for negative WTP (eqn 4 or 4')" ///
A9="alpha/_b[bid]" B9=manualWTP
*
*Calculating the Turnbull empirical distribution estimator using package turnbull:
turnbull bid bid_result
putexcel set RESULTS.xlsx, modify sheet("WTP measures")
putexcel A11="Turnbull Nonparametric Estimator for Williness to Pay per Carson et al (1994a,b) and Haab and McConnell (1997)" ///
A12=rscalarnames B12=rscalars
*
*Using spike package using Kristrom (1997):
*Gen whether have WTP at all by using general support/oppose policy question x1103B:
g wtp_at_all=0
replace wtp_at_all=1 if emission_limits==4 | emission_limits==5
spike wtp_at_all bid_result bid
putexcel set RESULTS.xlsx, modify sheet("WTP measures")
putexcel A17="Spike model for Williness to Pay per Kristrom (1997)" ///
A18=rscalarnames B18=rscalars ///
A19="See Stata output for add'l spike parameters."
*






quietly: svy: mean pct_bid educyears male household_size income_censored age white republican independent noparty globalwarming_no globalwarming_yes 
foreach i in educyears male household_size income_censored age white republican independent noparty globalwarming_no globalwarming_yes{
scalar s_`i'=_b[`i']
}
scalar alpha=0
svy: logit bid_result pct_bid educyears male household_size income_censored age white republican independent noparty globalwarming_no globalwarming_yes
foreach i in educyears male household_size income_censored age white republican independent noparty globalwarming_no globalwarming_yes{
*di "alpha start:" alpha
*di "coefficient:" _b[`i']
*di "mean value:" s_`i'
*di "product:" (_b[`i']*s_`i')
scalar alpha=alpha+(_b[`i']*s_`i')
*di "new alpha:" alpha
*di "  "
}
scalar alpha=alpha+_b[_cons]
*di _b[bid]
*di alpha
*di (1/_b[bid])*ln(1+exp(alpha))
di "Willingness to pay calculated as alpha/beta from Hanemann (1989) when allowing for negative WTP (eqn 4 or 4'):"
di alpha/_b[pct_bid]
scalar manualWTP=(alpha/_b[pct_bid])




svy: mean educyears
matrix svymeans=(_b[educyears])
foreach i in male household_size income_censored age white republican independent noparty globalwarming_no globalwarming_yes{
svy: mean `i'
matrix svymeans_`i'=(_b[`i'])
matrix svymeans=svymeans,svymeans_`i'
}
matrix rownames svymeans= "Mean"
matrix colnames svymeans= "educyears" ///
"male" ///
"household_size" ///
"income_censored" ///
"age" ///
"white" ///
"republican" ///
"independent" ///
"noparty" ///
"globalwarming_no" ///
"globalwarming_yes"
matrix list svymeans
*Now calculating WTP and CI's:
svy: logit bid_result pct_bid educyears male household_size income_censored age white republican independent noparty globalwarming_no globalwarming_yes

wtpcikr pct_bid educyears male household_size income_censored age white republican independent noparty globalwarming_no globalwarming_yes, mymean(svymeans) reps(1000)

wtpcikr pct_bid educyears male household_size income_censored age white republican independent noparty globalwarming_no globalwarming_yes, mymean(svymeans) reps(1000)seed(1)


*Calculating marginal effects using percents:
svy: logit bid_result pct_bid educyears male household_size income_censored age white republican independent noparty globalwarming_no globalwarming_yes
mfx compute


svy: logit bid_result bid
wtpcikr bid





*



/*
foreach i in a b c d e f g h i j k{
replace taxpct_`i'_p=0 if taxpct_`i'_p==.
}
*/
*Replacing . with 0 for the observations that should have 0 inputed: 
foreach i in taxpct_a_p taxpct_b_p taxpct_c_p taxpct_d_p taxpct_e_p taxpct_f_p taxpct_g_p taxpct_i_p taxpct_h_p taxpct_j_p taxpct_k_p{
replace `i'=0 if `i'==. & taxpct_total==100
}
*/
*Calculating the percent support and allotment of tax funds tables:
svy: mean taxpct_a_p if taxpct_total==100
matrix paystats2=((e(N)/e(N_pop))*100, _b[taxpct_a_p], _se[taxpct_a_p])
foreach i in /*a*/ b c d e f g h i j k{
svy: mean taxpct_`i'_p if taxpct_total==100
matrix stats_`i'_p=((e(N)/e(N_pop))*100, _b[taxpct_`i'_p], _se[taxpct_`i'_p])
matrix paystats2=paystats2\stats_`i'_p
}
matrix colnames paystats2= "% support" "mean % allotment" "std error allotment" 
matrix rownames paystats2= "Reduce Federal income taxes" ///
"Reduce Federal payroll taxes" ///
"Reduce corporate taxes" ///
"Pay down the national debt" ///
"Return the money to households" ///
"Assist workers in coal industry" ///
"Assist communities impacted g w" ///
"Clean energy (solar, wind)" ///
"Improve infrastructure" ///
"Prepare for global warming" ///
"Other"
matrix list paystats2
putexcel set RESULTS.xlsx, modify sheet("Tax Usage Prefs2")
putexcel A1=matrix(paystats2), names


*WTP for subgroups by political affiliation:
*Calculating WTP manually per Hanemann (1989):
quietly: svy: mean bid educyears male household_size income_censored age white republican independent noparty globalwarming_no globalwarming_yes 
foreach i in educyears male household_size income_censored age white republican independent noparty globalwarming_no globalwarming_yes{
scalar s_`i'=_b[`i']
}
scalar alpha_alt=0
quietly: svy: logit bid_result bid educyears male household_size income_censored age white republican independent noparty globalwarming_no globalwarming_yes
scalar beta_republican=_b[republican]
scalar beta_independent=_b[independent]
scalar beta_noparty=_b[noparty]
scalar beta_globalwarming_no=_b[globalwarming_no]
scalar beta_globalwarming_yes=_b[globalwarming_yes]
svy: logit bid_result bid educyears male household_size income_censored age white republican independent noparty globalwarming_no globalwarming_yes
foreach i in educyears male household_size income_censored age white globalwarming_no globalwarming_yes{
scalar alpha_alt=alpha_alt+(_b[`i']*s_`i')
}
scalar alpha_alt=alpha_alt+_b[_cons]
di "Willingness to pay, democrats:"
di alpha_alt/_b[bid]
di "WTP, republicans:"
di (alpha_alt+(beta_republican*1))/_b[bid]
di "WTP, independents:"
di (alpha_alt+(beta_independent*1))/_b[bid]
di "WTP, no party:"
di (alpha_alt+(beta_noparty*1))/_b[bid]
*WTP by whether believes climate change is occuring:
scalar alpha_alt2=0
svy: logit bid_result bid educyears male household_size income_censored age white republican independent noparty globalwarming_no globalwarming_yes
foreach i in educyears male household_size income_censored age white republican independent noparty{
scalar alpha_alt2=alpha_alt2+(_b[`i']*s_`i')
}
scalar alpha_alt2=alpha_alt2+_b[_cons]
di "WTP, global warming don't know:"
di (alpha_alt2)/_b[bid]
di "WTP, global warming no:"
di (alpha_alt2+(beta_globalwarming_no*1))/_b[bid]
di "WTP, global warming yes:"
di (alpha_alt2+(beta_globalwarming_yes*1))/_b[bid]
*
*
*
*
save tempCV1.dta, replace
*Adding in Six Americas indicator data:
use SixAmericasData.dta, clear
nsplit caseid, digits(1 4)
drop caseid caseid1
rename caseid2 caseid
save tempSixAmericas.dta, replace
use tempCV1.dta
merge 1:1 caseid using tempSixAmericas.dta
erase tempSixAmericas.dta
drop _merge
tab segment_brief
tab segment_brief, nol
g respgroups=segment_brief
_strip_labels respgroups
g dismissive=0
replace dismissive=1 if respgroups==6
g doubtful=0
replace doubtful=1 if respgroups==5
g disengaged=0
replace disengaged=1 if respgroups==4
g cautious=0
replace cautious=1 if respgroups==3
g concerned=0
replace concerned=1 if respgroups==2
g alarmed=0
replace alarmed=1 if respgroups==1
*

foreach i in dismissive doubtful disengaged cautious concerned alarmed{
quietly: svy: mean `i'
scalar s_`i'=_b[`i']
}

*Replacing global warming beliefs with Six America's scale using Concerned as baseline (largest group):

*quietly: svy: logit bid_result bid educyears male household_size income_censored age white republican independent noparty dismissive doubtful disengaged cautious alarmed
*scalar beta_dismissive=_b[dismissive]

scalar alpha_alt3=0
svy: logit bid_result bid educyears male household_size income_censored age white republican independent noparty dismissive doubtful disengaged cautious alarmed
foreach i in educyears male household_size income_censored age white republican independent noparty dismissive doubtful disengaged cautious alarmed{
scalar alpha_alt3=alpha_alt3+(_b[`i']*s_`i')
}
scalar alpha_alt3=alpha_alt3+_b[_cons]
di "WTP, overall:"
di (alpha_alt3)/_b[bid]
*
scalar alpha_alt4=0
quietly: svy: logit bid_result bid educyears male household_size income_censored age white republican independent noparty dismissive doubtful disengaged cautious alarmed
foreach i in dismissive doubtful disengaged cautious /*concerned*/ alarmed{
scalar beta_`i'=_b[`i']
}

svy: logit bid_result bid educyears male household_size income_censored age white republican independent noparty dismissive doubtful disengaged cautious alarmed
foreach i in educyears male household_size income_censored age white republican independent noparty{
scalar alpha_alt4=alpha_alt4+(_b[`i']*s_`i')
}
scalar alpha_alt4=alpha_alt4+_b[_cons]
di "WTP, alarmed:"
di (alpha_alt4+(beta_alarmed*1))/_b[bid]
di "WTP, concerned:"
di (alpha_alt4)/_b[bid]
di "WTP, cautious:"
di (alpha_alt4+(beta_cautious*1))/_b[bid]
di "WTP, disengaged:"
di (alpha_alt4+(beta_disengaged*1))/_b[bid]
di "WTP, doubtful:"
di (alpha_alt4+(beta_doubtful*1))/_b[bid]
di "WTP, dismissive:"
di (alpha_alt4+(beta_dismissive*1))/_b[bid]




/*
di (alpha_alt4+(beta_dismissive*1))/_b[bid]

/*
di (alpha_alt3+s_dismissive*beta_dismissive)/_b[bid]
di "WTP, not dismissive:"
di (alpha_alt3)/_b[bid]
di "WTP, dismissive:"
di (alpha_alt3+(beta_dismissive*1))/_b[bid]
*
*/
*/
svy: logit bid_result bid educyears male household_size income_censored age white republican independent noparty globalwarming_no globalwarming_yes
*outreg2 using "supplemental table.xls", ctitle(model 1) replace
svy: logit bid_result pct_bid educyears male household_size income_censored age white republican independent noparty globalwarming_no globalwarming_yes
*outreg2 using "supplemental table.xls", ctitle(model 2) append


*Calculating the WTP for model 1:
svy: logit bid_result bid educyears male household_size income_censored age white republican independent noparty
*Calculating WTP and confidence intervals for preferred specification using package wtpcikr:
*First make vector of svy weighted means to use:
svy: mean educyears
matrix shortsvymeans=(_b[educyears])
foreach i in male household_size income_censored age white republican independent noparty{
svy: mean `i'
matrix shortsvymeans_`i'=(_b[`i'])
matrix shortsvymeans=shortsvymeans,shortsvymeans_`i'
}
matrix rownames shortsvymeans= "Mean"
matrix colnames shortsvymeans= "educyears" ///
"male" ///
"household_size" ///
"income_censored" ///
"age" ///
"white" ///
"republican" ///
"independent" ///
"noparty"
matrix list shortsvymeans
*Now calculating WTP and CI's:
svy: logit bid_result bid educyears male household_size income_censored age white republican independent noparty
*Do as 10,000 replications:
wtpcikr bid educyears male household_size income_censored age white republican independent noparty, mymean(shortsvymeans) reps(10000)

wtpcikr bid educyears male household_size income_censored age white republican independent noparty, reps(1000)

save contingentvaluationdata.dta, replace
