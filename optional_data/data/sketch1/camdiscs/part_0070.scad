$fn = 32;

// ----------------------------------------------------------------------
// Cam disc: base radius 17.0 mm, lift 10.0 mm, 20 profile points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[44, 19.516], [44.157, 25.09], [43.601, 31.577], [40.801, 38.511], [35.022, 44.205], [27, 46.516], [18.657, 45.194], [11.13, 41.359], [5.157, 35.386], [1.321, 27.859], [0, 19.516], [1.321, 11.172], [5.998, 4.257], [13.199, 0.52], [20.659, 0], [27, 1.476], [32.253, 3.348], [36.992, 5.762], [40.753, 9.523], [43.168, 14.262]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
