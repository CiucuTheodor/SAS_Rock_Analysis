# Custom SAS Visual Analytics Walkthrough: Classic Alt-Rock

This guide adapts your original Visual Analytics lab specifically for your **ClassicAltRock.csv** dataset. Follow these steps in your SAS Viya browser interface to build an interactive dashboard!

## 1. Project Setup
1. In the SAS Viya Applications Menu (☰), select **Explore and Visualize** (or click it from the home page).
2. Start a new report by clicking **New report**.
3. On the left side, click the **Data** pane icon, then click **Add data**.
4. Select your `ClassicAltRock.csv` dataset.
5. *Understanding the Data:*
    * **Categories (Discrete):** Artist, Album, Track, Mode, Time_Signature
    * **Measures (Continuous):** Popularity, Duration, Danceability, Energy, Acousticness, Tempo, Year

## 2. Interactive Controls (Drop-downs and Buttons)
We want to be able to filter the dashboard by specific bands and track types.

1. **Artist Drop-down:**
    * Go to the **Objects** pane on the left. Expand **Controls** and drag a **Drop-down list** to the top of your empty report.
    * Click the new object. On the right side, click **Assign Data** and add **`Artist`** as the Category.
    * Open the **Options** pane (on the right) to style it:
        * Change the Title to "Select an Artist".
        * Change the font to Arial or Anova, size 10.
        * Set the Background color to a light gray or blue.
2. **Mode Button Bar:**
    * Drag a **Button Bar** from the Controls menu and drop it to the right of your Artist drop-down.
    * Assign **`Mode`** (Major/Minor key flag) as the Category. This lets you quickly filter songs that are mathematically Major vs Minor!

## 3. Creating Visualizations
Now we will build the actual charts to visualize rock trends!

1. **Time Series Plot (Evolution of Rock):**
    * From the **Objects** pane under **Graphs**, drag a **Time series plot** below your controls.
    * Under **Assign Data**:
        * Set **Time axis** to **`Year`**.
        * Set **Measure** to **`Popularity`** (change the aggregation to Average instead of Sum if possible).
    * This graph will now show you how the popularity of tracks trends over the decades!
2. **Linear Regression (Predicting Popularity):**
    * Expand **Statistics** in the Objects pane and drag a **Linear regression** graph to the right of your Time series plot.
    * Under **Assign Data**:
        * Set **Response** to **`Popularity`**.
        * Set **Continuous effects** (Underlying factors) to: `Danceability`, `Energy`, `Acousticness`, and `Tempo`.
    * Look at the **Fit Summary** tab on the graph. Which audio feature has the highest R-Square correlation with a track's popularity?

## 4. Making the Dashboard Interactive
Right now, your drop-downs and your graphs are not connected. Let's link them!

1. Look at the right-side menu and click the **Actions** pane (it looks like two linked boxes).
2. Check the box that says **Automatic actions on all objects**.
3. *Test it out!* Click on your Artist drop-down and select "Nirvana". You will instantly see the Time Series Plot and the Linear Regression update to *only* show Nirvana's data! Click the Mode buttons to see how their Major vs Minor songs compare.

## 5. Automated AI Insights (Explain Data)
SAS Viya has built-in AI that can write automated reports about your variables.

1. Go to your **Data** pane on the left.
2. Right-click on **`Popularity`**.
3. Select **Explain data -> Add full explanation to new page**.
4. SAS will automatically generate a brand new tab in your dashboard filled with AI-generated text, charts, and correlations explaining exactly what makes an Alt-Rock song popular!
