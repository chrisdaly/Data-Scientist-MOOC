# Suppose that 18 obese subjects were randomized, 9 each, to a new diet pill and a placebo. 
# Subjects' body mass indices (BMIs) were measured at a baseline and again after having received the treatment or placebo for four weeks.
# The average difference from follow-up to the baseline (followup - baseline) was ???3 kg/m2 for the treated group and 1 kg/m2 for the placebo group. 
# The corresponding standard deviations of the differences was 1.5 kg/m2 for the treatment group and 1.8 kg/m2 for the placebo group. 
# Does the change in BMI over the two year period appear to differ between the treated and placebo groups? 
# Assuming normality of the underlying data and a common population variance, give a pvalue for a two sided t test.


mean.diff = -3-1
df = (9 + 9 - 2)
m_tr = -3
m_pb = 1
s_tr = 1.5
s_pb = 1.8
pooled.var = (s_tr^2 * 9 + s_pb^2 * 9)/df
se.diff = sqrt(pooled.var/9 + pooled.var/9)
t.obt = mean.diff / se.diff
t.obt