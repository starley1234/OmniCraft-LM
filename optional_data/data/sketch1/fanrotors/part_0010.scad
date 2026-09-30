$fn = 32;

// ----------------------------------------------------------------------
// Fan rotor section: 7 blades, 12 mm hub radius, 8 mm blades
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 21;      // points of the closed outline

profile = [[31.383, 16.729], [35.793, 25.113], [38.844, 26.078], [29.524, 26.975], [25.719, 35.65], [26.866, 38.638], [20.354, 31.91], [11.199, 34.344], [9.579, 37.103], [10.779, 27.817], [3.168, 22.177], [0, 22.631], [8.008, 17.779], [7.673, 8.312], [5.343, 6.118], [14.129, 9.355], [21.322, 3.189], [21.584, 0], [24.532, 8.887], [33.836, 10.667], [36.493, 8.883]];  // single closed polygon, 21 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
