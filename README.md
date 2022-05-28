# 2022 北京大学博士学位论文英文模板
**该模板已提交至 Overleaf Gallery，点此[链接](https://www.overleaf.com/latex/templates/2022-peking-university-doctoral-dissertation-template-english-version/jxtvktyjvvtv)跳转**

在北京大学硕士学位论文模板 ([iofu728](https://www.overleaf.com/latex/templates/2021-peking-university-master-thesis-template-iofu728-pkuthss/rwfvbkpzydpf)) 的基础上进行了以下改进:

* 将中文模板更改为英文模板。
* 将参考文献编译器从 biber 更改为 BibTeX，避免原先的 textcite 等。
* 增加学位论文答辩委员会名单、博士学位论文答辩委员会决议书、提交终版学位论文承诺书 (在模板中均由版权声明代替，需要替换你自己的文件)。
* 使 enumitem 支持 (1)、(a)、(i) 等格式，避免原先的 arabic, roman 等。
* 增加定理类环境和证明环境，增加插入表格、算法、图片等代码。

有任何疑问、建议、反馈可以通过邮件或 iMessage 联系我: zqye@quicy.cn。

## 其他说明
* 打个广告，高效使用 LaTeX 可参考: [高效使用 LaTeX](https://quicy.notion.site/LaTeX-6be09d441a594bed84d59dba2b254034)。
* TexLive 2021 以上的版本在替换带有二维码的版权声明或其他文件时，可能会报错，目前暂无解决方法。本地需使用 2020 及以下版本的 TexLive 编译，Overleaf 可以在左上角 Menu 中更改 TexLive 版本为 2020。
* TexLive 2018 版本可能需要注释 pkuthss.cls 文件中的 `\RequirePackage{chngcntr}`。