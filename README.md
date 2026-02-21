# MCTI_6530
Submission 2 – Malicious Payload Dataset

Course: CIS 6530
Project: Project 1 – APT Group Set
Submission: 2
Prepared by: Nimmi Chaudhary/ Batul Ismail

1. Overview

This repository contains a curated dataset of malicious payload samples associated with the assigned Advanced Persistent Threat (APT) groups for Project 1.

The objective of this submission is to collect, organize, and document real-world malicious artifacts that are directly attributable to the selected APT groups. These samples will be used in later stages of the project for static analysis and opcode extraction.

The dataset prioritizes:

Clear APT attribution

Diverse payload types

Verified hash traceability

Safe containment practices

Professional organization

2. Repository Structure

The repository is organized into two primary directories:

Executable_Malware/
Other_Payloads/
Executable_Malware

This folder contains compiled executable malware samples, including but not limited to:

Windows Portable Executables (.exe)

Dynamic Link Libraries (.dll)

Linux Executables (.elf)

Windows Installer Packages (.msi)

Other binary formats capable of direct execution

These files represent backdoors, droppers, remote access tools (RATs), credential stealers, and other core malicious components associated with the assigned APT groups.

Other_Payloads

This folder contains malicious delivery artifacts and supporting payloads such as:

Microsoft Office documents (.doc, .docm, .xls, .xlsm)

Rich Text Format files (.rtf)

PDF documents (.pdf)

Script-based loaders (.ps1, .vbs, .hta)

Compressed archives (.zip, .rar, .cab)

HTML or phishing-related files

These artifacts are typically used for spear-phishing, initial access, or staging phases of APT campaigns.

3. Attribution and Collection Methodology

The dataset was assembled using a structured and traceable approach:

Assigned APT groups were identified from the Project 1 requirements.

Associated malware families were mapped using the MITRE ATT&CK framework.

Threat intelligence reports and vendor advisories were reviewed to extract Indicators of Compromise (IOCs).

Hash values (MD5, SHA1, and SHA256) were verified using malware analysis platforms such as VirusTotal and Hybrid Analysis.

Only samples with reliable attribution to the assigned APT groups were included.

Each file is traceable to at least one documented intelligence source.

4. Naming Convention

All samples follow a standardized naming format:

APTGroup_MalwareFamily_extension_SHA256

Example:

G0010_Turla_BadNews_exe_901e5b0b6297dc6c14d0a9d972c73edf64125d74cf307395d142a4dc428b14ef

This convention ensures:

Clear mapping to the APT group

Identification of malware family

Unique hash-based traceability

Consistent organization across the dataset

5. Inclusion Criteria

Samples were included if they:

Are explicitly linked to assigned APT groups

Have verifiable hash values

Are identified as malicious by multiple detection engines

Represent diverse payload categories

Are non-duplicate entries

6. Exclusion Criteria

Samples were excluded if they:

Could not be confidently attributed

Were unrelated generic malware

Lacked sufficient metadata for verification

Were corrupted or incomplete

7. Safety and Containment Procedures

⚠ WARNING: DO NOT EXECUTE THESE FILES OUTSIDE A CONTROLLED ENVIRONMENT.

All samples were collected and stored inside an isolated virtual machine configured with:

Network disabled or restricted mode

No shared folders with host system

Disabled clipboard and drag-and-drop features

Snapshot restoration prior to and after collection

The files are provided strictly for academic research and static analysis purposes.

No malware was executed outside a sandboxed environment.

8. Ethical and Academic Use Notice

This dataset has been compiled exclusively for educational purposes as part of CIS 6530 coursework. The repository is not intended for redistribution or operational use.

All samples were sourced from publicly documented threat intelligence materials and verified using reputable malware analysis platforms.
