# Drift Diffusion Modeling Analysis for Emotion-Guided Perceptual Decision-Making

This repository contains the analysis code and data for the project "Comparing Three Drift Diffusion Modeling Frameworks to Investigate Emotion-Guided Perceptual Decision-Making." It employs the `dockerHDDM`, `PyDDM`, and `hBayesDM` frameworks to investigate the effects of spatial frequency (SF) and attention on emotion-guided decision-making. Below are the setup and execution instructions for each framework.

---

## dockerHDDM Instructions

`dockerHDDM` offers a pre-configured Python environment via containerization, enabling seamless execution of Hierarchical Drift Diffusion Model (HDDM) models across platforms (e.g., Mac and Windows) with parallel MCMC sampling for enhanced efficiency.

### Folder Structure

- **docker_HDDM**  
  The main directory, containing:
  - **HDDM_Tutorial.docx**  
    A guide detailing the setup and use of the `dockerHDDM` environment, including Docker installation, image pulling, container execution, Jupyter Notebook access, and code execution steps, suitable for beginners.
  - **DIC_Folder**  
    Contains Deviance Information Criterion (DIC) results for seven models (M0-M6). DIC evaluates model fit quality, with lower values indicating better models. Pre-computed DIC results are provided for initial selection of the best model.
  - **Analysis_Folder**  
    Includes Jupyter Notebooks and data files for analysis:
    - **HDDM_Compare.ipynb**: Validates the fit quality of models M0-M6 using DIC values, Posterior Predictive Checks (PPC), and convergence diagnostics, confirming the best model.
    - **m5_HDDM.ipynb**: Conducts detailed analysis of the best model M5 (lowest DIC), covering parameter estimation, convergence diagnostics, PPC, and ROPE+HDI statistical inference, exploring the effects of SF and attention on decision-making.
    - **HDDM_InconStim_6Frame.csv**: Experimental behavioral data with 9750 trials of incongruent 6-frame spatial frequency stimuli, formatted for HDDM input.

### Environment Setup and Execution Steps

1. **Install Docker**  
   Download and install Docker Desktop (supports Mac and Windows) from the [Docker website](https://www.docker.com/get-started/). Verify installation with:
   ```bash
   docker run hello-world
   ```

2. **Prepare Local Files**  
   Place the following files in a single local directory (e.g., `docker_HDDM/Analysis_Folder`):
   - Data file: `HDDM_InconStim_6Frame.csv`
   - Folder: `DIC_Folder`
   - Analysis Notebooks: `HDDM_Compare.ipynb`, `m5_HDDM.ipynb`

3. **Pull Image and Run Container**  
   Execute the following command to start the `dockerHDDM` container, mounting the local directory and mapping the Jupyter port:
   ```bash
   docker run -p 8888:8888 -v /path/to/Analysis_Folder:/home/jovyan/work hcp4715/hddm
   ```
   Replace `/path/to/Analysis_Folder` with the absolute path to the local directory.

4. **Access Jupyter Notebook**  
   Upon container startup, the terminal will display a URL (e.g., `http://127.0.0.1:8888/?token=...`). Open this URL in a browser to access the Jupyter interface and view files in `/home/jovyan/work`.

5. **Execute Analysis**  
   - Review pre-computed DIC results in `DIC_Folder` to identify the best model among M0-M6.
   - Open `HDDM_Compare.ipynb` and run each cell to validate DIC results, assess model fit quality, PPC, and convergence diagnostics, confirming M5 as the best model.
   - Open `m5_HDDM.ipynb` and run each cell to analyze M5’s convergence, PPC, and parameter inference.
   - Ensure `HDDM_InconStim_6Frame.csv` is in the correct path; Notebooks will load the data automatically.

6. **Result Interpretation**  
   - Lower DIC values indicate better model fit.
   - Verify MCMC convergence using trace plots, Gelman-Rubin statistic (R̂≈1.01), and effective sample size (ESS≥400).
   - PPC plots compare model-predicted and actual reaction time distributions.
   - ROPE+HDI methods assess the practical significance of parameter estimates.

### Notes

- Delete old `db/traces` cache files before mounting the directory to avoid interference.
- `dockerHDDM` is based on HDDM 0.8, incorporating custom `hddm`, `kabuki`, and `ArviZ` tools.
- MCMC sampling is computationally intensive (9750 trials may take ~3 hours); reduce sample size or chain number for initial testing.
- Address convergence issues (ESS<400) by increasing sample size or adjusting parameters.

---

## PyDDM Instructions

`PyDDM` is a Python-based Drift Diffusion Model (DDM) framework offering flexible model construction and rapid parameter estimation, ideal for studying the effects of SF and attention to decision-making.

### Folder Structure

- **PyDDM**  
  The main directory, containing:
  - **BIC_Folder**  
    Contains Bayesian Information Criterion (BIC) results for seven models (M0-M6). BIC balances model fit quality and complexity, with lower values indicating better models. Pre-computed BIC results are provided for initial selection of the best model.
  - **Analysis_Folder**  
    Includes Python scripts and data files for analysis:
    - **m3_PyDDM.ipynb**: Performs detailed analysis of the best model M3 (lowest BIC), covering model fitting, diagnostics, fit quality visualization, and parameter estimation, examining SF and attention effects on drift rate and decision boundary.
    - **HDDM_InconStim_6Frame.csv**: Experimental behavioral data with 9750 trials of incongruent 6-frame spatial frequency stimuli, formatted for PyDDM input.

### Environment Setup and Execution Steps

1. **Install Python Environment**  
   Use [Anaconda](https://www.anaconda.com/) to create a virtual environment. After installing Anaconda, run:
   ```bash
   conda create -n pyddm_env python=3.8
   conda activate pyddm_env
   ```

2. **Install PyDDM and Dependencies**  
   Install required libraries per the [PyDDM documentation](https://pyddm.readthedocs.io/en/latest/installing.html):
   ```bash
   pip install pyddm
   pip install numpy pandas matplotlib
   ```

3. **Prepare Local Files**  
   Place the following files in a single local directory (e.g., `PyDDM/Analysis_Folder`):
   - Data file: `HDDM_InconStim_6Frame.csv`
   - Folder: `BIC_Folder`
   - Analysis Notebook: `m3_PyDDM.ipynb`

4. **Run Jupyter Notebook**  
   Start Jupyter Notebook:
   ```bash
   jupyter notebook
   ```
   Open `m3_PyDDM.ipynb` in the browser, verifying the data file path.

5. **Execute Analysis**  
   - Review pre-computed BIC results in `BIC_Folder` to identify the best model among M0-M6.
   - Open `m3_PyDDM.ipynb` and run each cell to fit the M3 model (the best model), evaluate fit quality, parameter estimation, and visualizations (e.g., reaction time distribution fit).
   - Examine the effects of SF and attention to drift rate (v) and decision boundary (a).

6. **Result Interpretation**  
   - Lower BIC values indicate better model fit.
   - Fit quality plots demonstrate the alignment of model-predicted and actual reaction time distributions.
   - Parameter estimates (e.g., drift rate, boundary separation) reflect the influence of SF and attention.

### Notes

- Ensure Python environment compatibility with PyDDM (Python 3.8 recommended).
- Place `HDDM_InconStim_6Frame.csv` in the same directory as the Notebook.
- PyDDM is faster but non-hierarchical, potentially less precise for individual differences compared to HDDM.
- Address installation or runtime issues using the [PyDDM documentation](https://pyddm.readthedocs.io/en/latest/).

---

## hBayesDM Instructions

`hBayesDM` is an R-based framework leveraging Stan for Bayesian modeling, suitable for small-sample group-level hierarchical parameter estimation, analyzing SF and attention effects on decision-making.

### Folder Structure

- **hBayesDM**  
  The main directory, containing:
  - **Analysis_Folder**  
    Includes R scripts and data files for analysis:
    - **M0_Incongruent_6.R**: A comprehensive script for the baseline model M0, covering model fitting, convergence diagnostics, posterior distribution visualization, and ROPE statistical inference.
    - **hBayesDM_data.txt**: Experimental behavioral data with 9750 trials of incongruent 6-frame spatial frequency stimuli in tab-separated plain text format, including subject ID, choice, reaction time, and other fields.

### Environment Setup and Execution Steps

1. **Install R and RStudio**  
   Download and install [R](https://www.r-project.org/) (version 4.0 or higher recommended) and [RStudio](https://posit.co/download/rstudio-desktop/).

2. **Install hBayesDM and Dependencies**  
   Install the following packages in R or RStudio:
   ```R
   install.packages("hBayesDM", dependencies = TRUE)
   install.packages(c("RStan", "tidyverse"))
   ```

3. **Prepare Data**  
   Ensure `hBayesDM_data.txt.` is in `hBayesDM/Analysis_Folder`, formatted as tab-separated plain text with column names matching hBayesDM requirements (e.g., subjID, choice, rt) and no missing values. Convert `HDDM_InconStim_6Frame.csv` to txt format if necessary.

4. **Run Analysis**  
   - Open RStudio and load `M0_Incongruent_6.R`.
   - Execute the script line by line, including:
     - Fitting the M0 model with `choiceRT_ddm()`, specifying the data path, 4000 iterations, 1000 burn-in, and 4 chains.
     - Visualizing group and individual parameter posterior distributions (drift rate delta, boundary separation alpha, starting point beta, non-decision time tau).
     - Checking MCMC convergence (trace plots, R_hat≈1.01, n_eff≥400).
     - Plotting parameter histograms, posterior density, and ROPE/HDI intervals.
     - Calculating DIC to assess model fit.

5. **Result Interpretation**  
   - The M0 model permits parameter variation across subjects but does not support conditional dependencies on SF or attention.
   - Posterior distributions yield estimates of drift rate, boundary separation, starting point, and non-decision time.
   - ROPE+HDI methods evaluate the practical significance of parameters.

### Notes

- Data must be in tab-separated txt format with column names strictly adhering to hBayesDM requirements.
- Use ≥4000 iterations, 1000 burn-in, and 4 chains to ensure stable convergence.
- hBayesDM supports only the baseline M0 model, limiting conditional dependency analysis.
- Address installation or runtime issues using the [hBayesDM documentation](https://cran.r-project.org/web/packages/hBayesDM/hBayesDM.pdf).

---

## Contact Information

For inquiries, please contact:
- Lin Zexi (`u3582512@connect.hku.hk`)
- Wang Yue (`u3642728@connect.hku.hk`)
- Yang Xueqian (`u3642733@connect.hku.hk`)
- Supervisor: Professor Jin Jingwen Frances
