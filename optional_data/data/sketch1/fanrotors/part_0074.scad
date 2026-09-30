$fn = 32;

// ----------------------------------------------------------------------
// Fan rotor section: 7 blades, 15 mm hub radius, 8 mm blades
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 21;      // points of the closed outline

profile = [[37.298, 18.88], [41.67, 28.99], [44.595, 30.332], [34.974, 31.688], [29.796, 41.408], [30.57, 44.533], [23.512, 37.856], [12.683, 39.868], [10.724, 42.422], [11.543, 32.74], [3.218, 25.529], [0, 25.589], [8.08, 20.193], [8.528, 9.188], [6.474, 6.709], [15.731, 9.662], [24.614, 3.151], [25.272, 0], [28.734, 9.078], [39.363, 11.963], [42.237, 10.513]];  // single closed polygon, 21 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
