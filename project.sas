/******************************************************************
 * SAS Project: Classic Alternative Rock Data Analysis
 * Refactored into 10 Distinct Exercises
 ******************************************************************/

* Exercise 1. Creating a SAS data set from external files;
PROC IMPORT DATAFILE='/home/u64491128/ClassicAltRock.csv' 
            OUT=work.ex1_data 
            DBMS=CSV REPLACE;
    GETNAMES=YES;
    GUESSINGROWS=MAX;
RUN;

* Exercise 2. Using SAS functions;
* Using SCAN to get the first word of the Track and PROPCASE to format Album;
DATA work.ex2_functions;
    SET work.ex1_data;
    First_Word = SCAN(Track, 1, ' ');
    Clean_Album = PROPCASE(Album);
RUN;

* Exercise 3. Iterative and conditional processing of data;
* Categorizing Energy into Low, Moderate, and High;
DATA work.ex3_conditional;
    SET work.ex2_functions;
    length Energy_Level $ 10;
    if missing(Energy) then Energy_Level = 'Unknown';
    else if Energy < 0.4 then Energy_Level = 'Low';
    else if Energy <= 0.7 then Energy_Level = 'Moderate';
    else Energy_Level = 'High';
RUN;

* Exercise 4. Using arrays;
* Multiplying specific audio metrics by 100 using a DO loop and an ARRAY;
DATA work.ex4_arrays;
    SET work.ex3_conditional;
    ARRAY audio_metrics[*] Acousticness Instrumentalness Liveness;
    do i = 1 to DIM(audio_metrics);
        audio_metrics[i] = ROUND(audio_metrics[i] * 100, 0.1);
    end;
    drop i;
RUN;

* Exercise 5. Creating data subsets;
* Isolating only the tracks released in the 1980s;
DATA work.ex5_subset80s;
    SET work.ex4_arrays;
    where Year >= 1980 and Year <= 1989;
RUN;

* Exercise 6. Creating and using user-defined formats;
* Creating a format mapping for the Time_Signature variable;
TITLE "Format Catalog Details for timefmt";
PROC FORMAT FMTLIB;
    value timefmt
        1-3 = 'Unconventional Time'
        4   = 'Standard 4/4 Time'
        5-7 = 'Complex Time';
RUN;
TITLE;

* Exercise 7. Combining data sets with specific SAS and SQL procedures;
* Calculating average acousticness per year and left joining it to the main dataset;
PROC SQL;
    Create table work.avg_acoustic as
    Select Year, mean(Acousticness) as Avg_Acousticness_Year
    from work.ex4_arrays
    group by Year;
QUIT;

PROC SQL;
    Create table work.ex7_combined as
    Select a.Track, a.Artist, a.Year, a.Acousticness, b.Avg_Acousticness_Year
    from work.ex4_arrays as a
    left join work.avg_acoustic as b
    On a.Year = b.Year;
QUIT;

* Exercise 8. Using statistical procedures;
* Analysis of Variance (ANOVA) to see if Loudness varies significantly across Energy Levels;
TITLE "ANOVA: Loudness across Energy Levels";
PROC ANOVA DATA=work.ex4_arrays;
    CLASS Energy_Level;
    MODEL Loudness = Energy_Level;
RUN;
TITLE;

* Exercise 9. Using report procedures;
* Printing the 1980s subset with our custom Time Signature format;
TITLE "Report of 1980s Tracks with Time Signature Formats";
PROC PRINT DATA=work.ex5_subset80s(OBS=15) label noobs;
    var Track Artist Year Energy_Level Time_Signature;
    format Time_Signature timefmt.;
    label Energy_Level = "Energy Level"
          Time_Signature = "Musical Time Signature";
RUN;
TITLE;

* Exercise 10. Generating graphs;
* Creating a 3D Pie Chart of the Energy Levels;
GOPTIONS reset=all;
TITLE "Distribution of Tracks by Energy Level";
PROC GCHART data=work.ex4_arrays;
    PIE3D Energy_Level;
RUN;
QUIT;
