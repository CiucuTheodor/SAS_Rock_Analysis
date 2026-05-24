# Custom SAS Model Studio Walkthrough: Classic Alt-Rock

This guide adapts your original lab instructions specifically for your **ClassicAltRock.csv** dataset. Follow these steps in your SAS Viya browser interface!

## 1. Project Setup
1. Open **SAS Data Explorer** (Manage Data) and load `ClassicAltRock.csv`.
2. Click **Actions -> Build Model** (or press the Build Models button).
3. Choose the type **Data Mining and Machine Learning** and set your data source.
4. Name your project (e.g., *Alt-Rock Analysis*).

## 2. Defining the Objective (Target Variable)
In your lab, you analyzed hotel prices (`adr`). For your project, we will analyze what makes a track popular: **`Popularity`**.
1. In the **Data tab**, find the `Popularity` variable.
2. Change its **Role** from *Input* to **Target**.
3. Check the **Level**: Ensure it is set to **Interval** (since popularity is a numerical score from 0-100).
4. *Optional:* Set Lower Limit to 0 and Upper Limit to 100.

## 3. Preprocessing Variables
We need to check the remaining input variables and transform them where necessary.
1. Find the `Artist`, `Album`, and `Track` variables. You may want to change their role to **Rejected** (since we don't want the model to just memorize song names, we want it to learn from the audio features).
2. Change the **Level** of `Mode` and `Time_Signature` to **Nominal** (since they are categorical flags, not continuous numbers).
3. If you decide to keep `Time_Signature`, you can use the **One-hot encoding** method for it just like the lab did for hotel categories.

## 4. Pipeline 1: Supervised Learning (No Preprocessing)
1. Go to the **Pipelines tab**. Rename *Pipeline 1* to **"First flow"** by right-clicking it.
2. From the nodes menu, expand **Supervised Learning**.
3. **Linear Regression:** Drag and drop the `Linear Regression` node over the `Data` node to connect them.
    * Click the new node. In the right panel, change the *Selection method* to **Backward**.
    * Change the *Effect-selection criterion* to **R-Square**.
4. **LASSO:** Drag and drop another `Linear Regression` node over the `Data` node. This time, change its parameters to be a **LASSO** model.
5. **Additional Models:** Drag and drop the following models over the `Data` node:
    * `Quantile Regression` (leave default parameters)
    * `SVM` (Support Vector Machine)
    * `Forest` (Random Forest)
6. Rename each node (Right Click -> Rename) to easily identify them.
7. Click **Run pipeline** and wait for the final **Model Comparison** node to turn green.
8. Click the **Pipeline comparison** tab to see which model (e.g., Forest vs LASSO) was best at predicting Track Popularity!

## 5. Pipeline 2: Advanced Preprocessing
1. Click the **Plus sign (+)** next to the name of the first flow to create a new pipeline. Name it **"Second flow"**.
2. We will add **Data Mining Preprocessing** nodes:
    * **Anomaly detection:** Drag this over the `Data` node.
    * **Imputation:** Drag this over the `Anomaly detection` node. In the right panel, under *Interval Inputs*, select **Median**. Uncheck the "Reject original variables" option.
    * **Transformations:** Drag this over the `Imputation` node.
    * **Feature Extraction:** Drag this over the `Transformations` node. Select the extraction method as **PCA (Principal component analysis)**.
3. Now, drag the same supervised learning models (Linear Regression, LASSO, SVM, Forest) over the `Feature Extraction` node!
4. Run the pipeline and see if PCA and median imputation improved your predictive power for rock song popularity!
