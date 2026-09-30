$fn = 32;

// ----------------------------------------------------------------------
// Chain sprocket: 9 teeth, 22 mm root radius
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 18;      // points of the closed outline

profile = [[46.935, 20.564], [51.149, 28.096], [44.633, 35.436], [43.019, 43.914], [33.31, 45.348], [26.624, 50.806], [18.264, 45.664], [9.634, 45.547], [6.536, 36.234], [0, 30.597], [3.613, 21.472], [2.229, 12.953], [10.863, 8.284], [15.278, 0.869], [24.893, 2.842], [33.042, 0], [39.139, 7.692], [47.209, 10.753]];  // single closed polygon, 18 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
