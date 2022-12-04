#lang racket

;; 

(provide test-data data priority)

(define (parse d)
  (map string->list (string-split (string-trim d) "\n")))

(define raw-test-data
  "
vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw
")
(define test-data (parse raw-test-data))

(define raw-data
  "
pqgZZSZgcZJqpzBbqTbbLjBDBLhB
wHptFFsHttHFLMDQDFTbbj
fVfvsstwPHwNwfNGfHWRSnlpClcJzCWCzddSrddg
bdgHbZJHgMHgJgJctDtVssVcpFtq
rNNQqBSzTcBPTDsP
GWNNrhGnNnWNzRfnRQRbhCdqHMbdmbZddbmCmd
BSBDzrSwrqccDDwbfcBjsRwggClslTRWGWGMFlsF
dnhVhLJtzNZdgCRlsTGWCRJG
ZHZdNzptLNtPhPdnprPbbDBrSqrSQPjbqD
rlSwlrGvwTTSwSggCJGQJdhVgJGQ
jcrHrMWfNHNzQgVH
WbfjmBMrBrrmLtqMbwwsPTvPpwvBPFPsws
NRNcHzbzbMRcNPjPrrlBPlbtBl
CZwVCCpWggqprwtlHlssHtPr
WpmLghCVCqCnmVTLnccRQvvQQHDhNQzzzc
NvGTmNGDJsrCmCWPHpCP
nqfVfnFQnZQfFqzMZBPtppcBPPCBptcrbF
fhRSSVfqMZZhMnQfjVzShNNlLvldsNDdvvljGpllDT
JGRNWRGJbGmCGRbLmGpqShhcQpQgCcncScSQ
FFdtjvvpvVFnQhhnQhgf
ltvjjtjHlzBtWRmNPLZRHLpH
FFCJFsvgLsjLgWzJFWJgGwBDbwnbwlDddqffnjnlnd
pTpTMQpMZHQhZQpHPZMmTMlwhDNNddbnDqdDwwlbVNVd
SHpmrHPZHQpmvFrqsFvgCsRq
TtWpWhQlVZrVptJhtrtdbLPDPbjFbCCWCvFFbLSN
zMGlnlsgSSvjjGSF
msznlgcwMnRwznmBqTZQJrddhfQJtBJtZQ
mwTwLftmqqSHWfCfLHjWftBthNNNVrlcFRVNrNrRTrMgrRNg
pvJPJQPGPPzbpVpVlMBVchFl
bzQPQbQQdsDZPDGJnBGnPGnjHDttqqqqmCjftLCmWmfftC
ZNpfdHcccTfdwfMFNjBttMgMbBnvlvjBmB
QVPsGzhbszRLRrgvtgjWgljlRtgt
VJrVLsSrzLzGPChVGzbrrfpTSHFfDDHSdpZFfHpDTZ
NPpvDbmbsmdbNvQvDdWQpmWSnnQCLBnCcQSCnnLlwCBlZz
jggrtGTFhtGfjhDVjrjgMftFwnZcwwBCnzzVwBBwSZcVwLSw
JfHftHhgftgFJWPdPDWRPDvPJv
ZSLLZJGglDSVNDGGGgGgngGmHrfLzmHvvjfjwLhHvLfHHr
QqFWszFMTQFdFPMqBmWBHvfhCwCjhHff
pTsdppTMPtqqdbnlNVzJVbSSnbZR
gBqDccrrJDwmpTWHHTdWMPWWZFHF
RNfnfSwRjlLSWjQMHWvQZtvH
GRLbnzNnzVRLCqhwzwBmJrmc
CcGnZGnGlRncsspmFmmcmGRJJzCDTzjLBSDfqjwDDzDLDB
hHrNdPWhrbPdhPgVWvvrgWdfwjfNzSqfqjLqzfBTzJzJTz
HHQhhvMWbbdRswmlsmwsQc
rrwhpZPrccRpQdcFDJNqhtqtqMLhqfMh
lTtTllgbzTlJsmDMvbLbsf
VVWBTgzlzgGnngrtQRQRtCtwZRQB
HGnGvVdLhlFcmvPWmT
jwBLqZgjrtjqmFsQTscPQs
ZBNZtwLwztLpMrfZBLMdbdnfSRVVfnGbnfDVGh
LmBBBzQrBgBhmmggmtdVdhJNMHNdhsHNDd
ScSZbRplCcMnSpvCfCCZcpPwtJPNtHPHNVVNtPddwlNH
CpvpZGfnffSpnvRSSbcfScQBWrMWmjrmFFBzTGQWjMmL
sljSjSgsjcCLllsjVgSjCtspQwvNNhdFwFQvwpbtmhwhpN
hDqqWzGRHHfRrJnrWrfWfHBdFmBFmBbdBGBpwmFdFpww
TDnDHZrWWHhTjPClClSP
wGNQGQDGjqqmwHHs
MWvvrzgfsdWsvMrSdqJqcpgHgnqLFLnjpH
fvsPMsPdrTZhChNDhbhPVN
sbMgDDtttVvpMtcJsgcGGBBfGLBSLclQTGPS
CWHWzhhRRHjqRmSGPfBSzJfSBnBB
HjjRHWFWhRRwHNmCCRHhhFdNDNrdptMstJvsbMDtVptd
RnSwRsLsnSswjDDDBJPrJv
cpzCzlczHTJVQhvBQlDVDj
WmGzqTmHSsffqqnJ
vQSPHMwpmpQMLGfTPVLRPRVP
hsWhnncsJqbGjGfcfBMMRR
sqdNWqqghbsJslgsJqgWllMWDppSvNCHQHDSSHrHrHCSvvCQ
ZWWnWMmmndQZmffcdZcmssQqrsptVwwTtQHTCTHH
SvvrPzvvFDzGzTszpGGwHT
vrRLjjrPhLjrjPDSfdcMZnmdcmJcfcRf
HpqWhDJjzmcTSbmMBVBb
nCzfLtFnZZrcbcVVfTBfsc
FtRFzgrRtnRzrFwzDjljpjgHNJDlNlhN
gtNRRSSrRmjshHmm
PQDMwPwMppcQQcvCFlhLhGmjflctlnHGjf
QwDMFFdtwFDQJZZZNqSqJSqBgBqTNJNg
cddzbbzQflTDcDfRbcfbJVsplVsChNghHNsSsVpn
FBWFWjFFCjWPBSPPJsVpppPSVH
CrCwvjWvmqmvrBvFwZRGQQDDcGTcfbddZdRc
ZBQqdGLFmmzDmTZz
PvrVMvGgWmwSmllglS
NrfGnvWWPhfpspsGvLJBsFBbqJCbdQcLBq
DrwTrlfGThhQTpDdWSWgdgwLLgBSZH
bqbPRVRmzJCLWSgCzCLH
jRtbNVtNjNqRqsJtbjbMDQHQGlchfQpfsTcHpGHr
tMnRcnpDcZtpQDSCCsGGHvcGPGqGsr
mzJmjWJNlbfmbhzVCCPmZrCZqPGCgZ
JWhzjJBdWnMLZtSBTw
tvdLttzvtHLztnQpssdTPbMqbqMTdTss
jhSRGNjjSjhSDCNhRgRgclNjmfZTPnbTMqJJfqqsbMflTfMs
WnCjcjDRCChSNSCNDjNhGVDtQvVLHzFrpFwFrHFQQwQpzp
fLbLLLLQhVPhBVmDwmCfwsdwwDps
GNtctFTSrrJqGGpHFcTJFTwsslwmlmWsdsqRRCmqwdWs
ppctFTTSgHcSrGrrTGFcrrnhhQbPLbQZgzLvQQVVvZvLhv
mBBWnnBbBCtssmRThRDllR
wfwFQcpHFpddFrwpGcHSHdcjQZZlqqDTTjZqssRhWllssj
dWfrcSGFpgrSzFgMbCPNPLtCtVMV
llLlGLJJMjJMGVSvVMSLRRHvjCZtgZccttnmbCtdCcmCCztn
sBQNqPhsrrqrrwrsppsHswsZcmnNCzdZtbgntcNgcctnCt
WWFBBsPwpWPwBBHpFFrWGRMRLlJfJVMJRJLWSJ
vgMvQnPMntnSQPSgMvSMpNJfJDNNRpfZmGQmbDND
HlbjHHBLjCHGZGpfJLpfwm
qdHWqBbbbjrTzdqFqssvtPMSSFFg
TGDfDHSgtTzPPbnCtnNtVn
WQrWMFpMWMQbCVNPRWVWWv
pdpMMrhrprQshlMFjZpdjZMgmlGJJGlGDBmgmHgmJCSBHG
zWWBjZZjWPFFPPnBCVdsqmnCdSLn
rJvpbvbpGgTGrNJGGpRRhsCqSsLhnsmTVnSLTLHh
gNNNJDbpvGNfvNSDPPWQWWPZZWtjlQfc
RRVbWWWvvZVWmsFSsDNbHsDSsg
CrTwJQJpJpCCwvlJQTTPsfzDgfwNhszfszFhzFDh
ttQJtvjpPvcqTllJTPtPRGMGRGLWdVZLVZjWdMjj
NnPCTQWMMQNNNWwWnMzpHczzsZcCscddHdGs
mqRgqqVlLgqmfVzcGpzzSHGZcgcz
tjmZjZmhqftlJRJhlTMPTPQbrPBBWnhnnT
hvTQqpvTqjvhpjnCqmCnSDSFDWFFLSSSWDnSVL
tZwGgsfPcltgcZltRgNSDSSSSldmWMLWFVHd
GrZtwRPbGwwPcGRsZGtRtgQJJhCjpzmTBTvJzJrjvzQp
rwmwqDWwfDtztnFGBB
LPdpdVcdPGvPVgZsPtlhTTtthHBhHF
dRdCjvpCRpjvCMZgvLgRVJJSWMqmbwQJbMWGWQNbbQ
CMCcMcDGzBGPmBmznTNbnGbrswNTwTvN
SSHVWZphqWWJJzNsbnFwFVNjbz
flLQqHzzgtQdcDRB
mdzvFtllBgFttGnvfMwMVRRZCThSNZVhMd
pDTrDHjWWJPqjDjDSMqNwSZRZhNSRNCZ
jpcTpQPWLLpDTLcTrPjPDcjzzFLFzvgLzlzfvGFgfmgFzF
fQVVPzBpFVVrtrsJ
PldSLNSmWwMCcCMMcCNN
mSPlldllmPdRnLRwmbnLwmwvTjBTghTHQjfgjpZHpfHHfZbZ
pmfMcfprMqMrZZJcMZMGWTsFCVCTVPPsVTWCGPDP
vrvvvLRbBNNBbvBbjBHbQhgDslPTWsPTlFDsFTFwTWlDVQ
hgjznNBjHHgrhRHgrRLRnRfSSJmdqMfffzqJptdmmmdd
nRnPlCRPWPMFqwPLwq
tBGfbSbHtBVQgrbrqfTFFLvTNLLNGTGMLdws
bgHVtBDtqnqqlJRD
SdSJrHssFBSVsNtMMdRWnTRhRl
vcvfDvgvcwvFRlbnwWRlMhtn
DDDqcqFZQPgcgcfvDjLDfVrsSVrHBLJVpLpCSppGpS
gJGTFLTdrpLdBcWBvnllvlMvMC
RRqbbQhwNZZwQRPrSZWnvHSZWSvSZC
fQDNRsrsQzfbDrbsqwdtpgJVjdJdpVfJFLFF
DzWqFvqpqFSCSzGRGmwfntGjmR
cbhZNJQBtgMHJbJcNcrmfhrRrswmfRwnVrhG
bJNgbNdJBBPMHbcMNMWWvSFpDLFvCStqpLdv
sLsHTsTbRLRwqssHwHjFrPDwJDppzFDJmmcrPJ
BnZGBlMZnQSgSnvVSMmJzPDCzFcrLPPJmpDG
BgBffVLhQLgvnBRRssfqdfHbHdNT
HRPVmjqBqVjVRRPmcPmJjbDgLDDshbfRLlfbfLbhlL
rtTzSMSMFpTzfgDzzgsLfLHZ
rNpGpSSHwMTrrdHGNtTPmVjnGGjVjmBGmmBjJB
DBqDQDQHSFlHsFnN
MfLfwwLMWGLrWMMnpSlsnGJJlbFVjV
gRhMZzhrFLWQvTPqTPcvvh
NwwsHwtnFCtzcPdbvrQbBqclQq
VmZLLTLfVpwMBrVVqqMM
mgJDjTgWgLWDppJZJTWZmSRzCtRHhGGwHNzshGFFCSRt
RGCCDRdFZdRCMzzGCDGCmGHMfqbNNNLQLfFqnnqnNQqVPnQn
glgcrwrJjJccBwdSfnSnVqrqQVVnNq
jvtBsjstgstjltBcWzTGGddHTWDTZCmDGm
HJHGZZHnctSSDhZtmZ
MjjQFSvQlRjSdRqdqvVSqCCPtpRpPPDfDmfPbbpphC
SNsWqMNvFFqdqVMgwwBHrGHnHgcWTJ
jBcbjSmSBbbCcPcMjmbzFPhDMDfrfGRhGQRMnGQfdrDh
wHlqwlqpwZqcwVlqHtJVJLTdhndTDnhffftTGDTTDdTG
JNllcwpZZlpZJjNzSzSCNjSmFN
FhwRPzmPWmQQmwFPGGMGGRPnRHHVfDbvJlvDlHSvDTDfVHbD
NpjcpCdqpZZvwvJVfDdDHT
twZtqrBrBQBMBPGn
fBFGjbLLFblmbWFmVfBvrvMdMdncnrdNbdQNTr
shZHHRZhtsqJZhHhgZzgJzVJrrSSvrMdMQrNTvMNJQNrdn
szHwgtHtwPzPLpVFpVPLlfLC
mrsrtrWjljjjvwwgNnZfDHJDqTqrHL
FccMPFQcpczpdMPhMqJngNfqfnFgDnnFfg
BdMpdcDPcpjBmlBmVWts
VvwTTlfVlblwwSsbfTdzVqjhzVjpjjqjqpzV
rwCWFGmJrNCmMRHmwRFPmHQQhBLBzdLqBjhLBHZdQB
rFwDrMNRJDJFPRmCvcTcbDsvstTgfTsg
zhRzdRRChHCFGPDRvWRWvWvHpZpscrrmrZrJcmspJmJZFfpM
wQqLtQLtnjbjVnVjbBgjbBnbMZMZJlVpZfJprsMprmGZZZml
jQjjNBLLwjtQBtwwdGGDCHhNzzWDzTPD
DzzQnCMMznFnCdnFFlHtlmhVRtmVVmVhSF
PWrPPRTfLJJtfbtBfV
wsrggZsTwTTWGvDppQMRjjMCjMZp
fTjzZVTlbffCMvjgMpSFWBNBWSFsvBsNNccF
nJdwdPRQqGqbGJQbmmQQhRSBBBSsPPHWNSWFBtDNBsHH
nnQhwwQGdLqqwnZbpfjMfzpzLbLj
jgTgCwgjMgGLhvRrHrHwhvhV
bqSsSsZFZBlFsBlTSppVvVvnVHHvHnhp
qFlbPbFFsWFsBlFWbsbsmzTcMjLmtfcCmcWtgzgm
rrHbfBLbfMcghcmrcCzg
RDStDtvdZRQdJSQWWWdvFSgNvVcnghhmnnzhVPhczPch
ZtJpJttSZStwtttFDQmLGTlqMLqGfwTTGLfTGG
MrfLWwfBwgghvLmNvmHHHGGQHQSSscscVvTV
dDjZjDPJtFRzjdTTsqVjTpqHsGrT
JbFtlbPRJCzffBrgnlMWmg
ZFsbbVLLdZppLFpcJjCCQJlGcQCMZq
TwRtRBdBClCTGlcJ
rwBvBzDvwNNDHLHzfHssdHhS
gdhgftTNGTbpqJqjjgRJ
lcBcMLFzMzLFMzFzPjRBQjQPQpSqhpbp
mzzmZHZZnZwLhtGfddVsNCCnGG
lblbPGSGrTLRwqZLvP
FffCCFzFCWzzvmjRJnRTnZZNJCTqCR
gdhztVjhHMsGvrGVVB
ZJZjJGHZhDJRFJHjDZjhPNFgFmrnVmgVVzVBscnzSg
bwlWtMwtbqdCvlQCplmsqgnVVScnVgmnmzNs
WMWltTtvvCdwCCRPPfTHGcJDfGZL
svqQJLvSSZrZZZCFCBDPDCMTDpPwMWDPCwRw
GnlnGbdldjhzzhpPDTWjmtMwPmWW
HzVbGnnbchblbnbzcQTZBZrQrFSHvLBBJv
MmgMmVpcRDlvbvpHJF
GSGTLTwhwwhzQqTqwjFlbdvdbrlrbrrDnDvHlQ
zLNNNtwGFCMsWsCWNR
tSTDDDftSqSsTDnTtCWNrbFsNJJvbzJbvJ
dhRdVHdMGRgPJbjNPbzgvr
VllQmQdhRHLhhHmLlGzSqSQDDcDBnnBnqDfSct
zBzJWZBLZNNGLsbTvLbmbT
QdtQwfdnPdPTbsRQGhRvbl
pgtPgPjVDnpVnDtPTFFrJJTBCcpcrpCW
GnWMfBfdCGMbjRNpnzvvNLRNVv
FShJDJJscwwszNjvNjNNqZ
tJmccwlcFlFcHlPcHFfdrbBGBGfjCGTfBCPf
GhlcQsZNQZWhpcGhwlPmqnnqnjJjLRnqzJsJLJ
VTMtTtDTbvbMTfvdJqngjmqzdjmJjCLm
vHtbHTDBFvffBPGwLLZBQNNl
bDphJrpbpnBbDrdBvJdDFBMtMlfgtsFSstfGPPgggPGP
RZmNjTZQNVHQHNGSgMsfPlShSs
VmchTLZQLjVLjmTVmQVhTmwVrWJqbDqddBrpnWbvnqrqcnJB
jWWgThWtgSvSSWlJtlShllPcHVnJHPbMHPcPVPbVZrHM
fGdfRsRdNwfRQhnpcZdVhVpbPh
fGhwNBqNjqStFqtj
TSTBrSDlQlTDrrQclrBSLffPvcfcdVjVMGGPLjLL
qnbnbngFGhhhPfjjVffjff
RRWbmgpnmqlrCwwSrwmG
mZZTsdBZVZBZLVHdFmsNnCrCVQQbWvWjWNCnbg
QSffDGwGGrPGWrgN
hflwzltflDpMpDSllcMDhSShdsdZQdLZZdHTssZzmqLzFmLB
LLRJRshLfsJfWnLBTlTBlFzNrnrBBl
qmmVwmdHqmqGHZdHbbqSScdZQTjjpTFFVBBrlDrzDFBTjFjF
wZZwmcbvHgqTmGccmvdCLhCPJsJCPWgMLPtJsJ
TWbbbNbJJjJbqTjtJJjTQCtnGSBndMGCcSZSQwCB
mcfRfrcmrDRrPsdQSGZQGnsSQMnB
DDRLDRDFPpgmpcgPghpfgvRTjbhTVjHljJjzlVzVTlbHll
rPlPrPllBGgJgdJfHgfjJt
pppZVfFDWssMfFVVFMpsMMVmHCRLdcZCRtvLRdCtCJdHRttH
mDMfDFDmnMMmsMFznDFpzswbNbPGwwSGBrGrhrTzThSl
qDNFfCCNWLfWWhqhDGPMMZVwgpCpMbJwJCvV
RdstRRvdtmtPVpppVbVtrp
zzncSRdsTdQTczQBsLvvHNhDWGjDHNLDSG
bNNpcfJcCtNpHFsJsGGjLGzmLjLmGzlFGW
qwqZdnQnQwnhhzmnMWjmNlMzLr
qhwwQSwStJbHNftS
WlfWSwDftzRltBWVlRDlsmBJPcsZPmcJnmPmFhrn
dLQbQbvGTddTvbjQCbLbhmCrZZPPsshPPPrJZrnF
QgFjQHHbMvdRMVllSqfSlf
MDPJBWWPggVlPVDMSljdZNNpwjwbHZpNbDdH
mGmzcThGrtntHhthzGctRbNRNwRNzZwfdZpjpdRj
ThtcvvtThFcnqFQSHgBSVJll
hVqhFLBngHVFtJjtLCBJVSbbPNNbSmfLLTSNSrrLTb
vsdZZpvQdczlMdMvzlcvvdQprbGGTfSbWmzPTgmmGTbmmfGP
vgRZZMgwdgsQZdMBqVhjhJqBhJtRhq
bgFQbMMbTbQhghddFTFGnmSmsNdzHvzSSzlcHsls
fZDjVtfZLqwpqtCfCjCjlvqScrvzqHSzszzSnczr
jpftjCfWCjCfCRZZlpCpjRWQBRTQQbgBBTMbghgbbPGJBJ
VZZrbBVwbbbVVvgbntnggNRJqRRNNccMcNqJcJ
jfDPfDdGGhDGfGFPCcZQqMpRNJhqTcMc
LPfffPHGPDjPFGWSdHPFjWtlBlwvlwBlbtmLltsmvtZb
TTfJDfrJTSrHMcVMJDTfMcMDBQBPwnPlznPszFVBFgzFgnsn
CqtmWNNGBPzwbbwm
htdCthhWGtWWGNZqcZpJjwwHHHMcHZDM
VvjQjQCZLbbSbTPpSHtFzsHzppMfzz
DJrJWBcDcWJWmmcgGRGRGWGDzHHwzdfRHpMztMpfdFdFdzdM
DmBgGDqJNhGcccWmcZLjTPLVLTQhPtvvTZ
qfhvwNDQqwDGdGZZGwPTTw
STsJgsRtJMZPjlsmdpbs
SCTTHTWHNVfHQqqq
djCDgllgjJjDRRNgRlDdBgtpQHfhQTrLLrGBtzrQhpBH
SVcsMGcPSbqSPmLTPHHQTHrftPTr
VcWnsScqSScWcZbMMcSVGbNNlgDRlgCCNgwWvvRJdNdj
mgPllfRgvNmPGQGGsmQNWlpFtnBPFShncTFShtFShnjS
tLLzMJJwwbbdrrMLqLVJMzVZFnpTTFpnCSSpShCjBJhpThph
HMdVwbbLMbDMDVlmDsgtNtNRfgsm
hNsgsgzNZRghPhZBdssPQfzDmQSmmzQGJWzfCDJJ
bblVHvvHHTljwFCfGrvmfmmJBmGQ
THMMFVwqTPRdZptMBP
QvcPGSvQLjmcQWSGWWGjLCNhhqpCdBCNCbJNdVWpCh
rwtLlzZggLHnHlwHRDdVqBbCdqqVVhbqVnVh
zRDzwRrwlRlRTgrDtllmQGLcPjGLccFmTcGSQc
RWlgQlbcWBwzsJggTfhh
GrnLjHLjmLjjGSLjSDmfJJpfThhfSWJPqJqhwz
vLvDDnDNrCVjCmNDbFlBVZdVRQlRbWcb
mTlwFngwmlLlvsmLHmHsLJhJFfcbdpbNcjCNCbpccb
tZRzBRzBBRQzPqGRqrVQtjjfbCMcfMfCMMjVjfCJNd
SDBBPtZZTdnnwSvg
nddNNMMPNBnBNnBTQSShlSHghlDHBr
VcccVmqJsJsjlTmzTDggmHHT
VqLtFCqFJfVtVjsNgPNNMMWNwgtNvn
")
(define data (parse raw-data))

(define (priority ch)
  (hash-ref priority-hash ch))

(define priority-hash #hash(
                       (#\a . 1)
                       (#\b . 2)
                       (#\c . 3)
                       (#\d . 4)
                       (#\e . 5)
                       (#\f . 6)
                       (#\g . 7)
                       (#\h . 8)
                       (#\i . 9)
                       (#\j . 10)
                       (#\k . 11)
                       (#\l . 12)
                       (#\m . 13)
                       (#\n . 14)
                       (#\o . 15)
                       (#\p . 16)
                       (#\q . 17)
                       (#\r . 18)
                       (#\s . 19)
                       (#\t . 20)
                       (#\u . 21)
                       (#\v . 22)
                       (#\w . 23)
                       (#\x . 24)
                       (#\y . 25)
                       (#\z . 26)
                       (#\A . 27)
                       (#\B . 28)
                       (#\C . 29)
                       (#\D . 30)
                       (#\E . 31)
                       (#\F . 32)
                       (#\G . 33)
                       (#\H . 34)
                       (#\I . 35)
                       (#\J . 36)
                       (#\K . 37)
                       (#\L . 38)
                       (#\M . 39)
                       (#\N . 40)
                       (#\O . 41)
                       (#\P . 42)
                       (#\Q . 43)
                       (#\R . 44)
                       (#\S . 45)
                       (#\T . 46)
                       (#\U . 47)
                       (#\V . 48)
                       (#\W . 49)
                       (#\X . 50)
                       (#\Y . 51)
                       (#\Z . 52)))
