$fn = 32;

// ----------------------------------------------------------------------
// Arc stop: segment, 12 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 17;      // points of the closed outline

profile = [[46.712, 0], [46.161, 5.724], [44.528, 11.238], [40.819, 9.74], [37.359, 15.802], [32.411, 20.725], [26.332, 24.155], [19.559, 25.844], [12.581, 25.67], [5.901, 23.646], [0, 19.917], [5.142, 13.789], [12.358, 17.465], [20.455, 17.607], [27.794, 14.184], [32.891, 7.891], [34.712, 0]];  // single closed polygon, 17 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
