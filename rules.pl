center(X1, Y1, X2, Y2, CenterX, CenterY) :-
    CenterX is (X1 + X2) / 2,
    CenterY is (Y1 + Y2) / 2.

distance(X1a, Y1a, X2a, Y2a, X1b, Y1b, X2b, Y2b, Distance) :-
    center(X1a, Y1a, X2a, Y2a, Cx1, Cy1),
    center(X1b, Y1b, X2b, Y2b, Cx2, Cy2),
    Dx is Cx1 - Cx2,
    Dy is Cy1 - Cy2,
    Distance is sqrt(Dx*Dx + Dy*Dy).

located_on(Object1Class, Object2Class, ImageID) :-
    detected(Object1Class, X1a, Y1a, X2a, Y2a, ImageID),
    detected(Object2Class, X1b, Y1b, X2b, Y2b, ImageID),
    object_category(Object1Class),
    object_category(Object2Class),
    allowed_located_on(Object1Class, Object2Class),
    bbox_area(X1a, Y1a, X2a, Y2a, AreaA),
    intersection_area(X1a, Y1a, X2a, Y2a, X1b, Y1b, X2b, Y2b, Overlap),
    Overlap / AreaA >= 0.7. 

located_near(Object1Class, Object2Class, ImageID) :-
    detected(Object1Class, X1a, Y1a, X2a, Y2a, ImageID),
    detected(Object2Class, X1b, Y1b, X2b, Y2b, ImageID),
    object_category(Object1Class),
    object_category(Object2Class),
    allowed_located_near(Object1Class, Object2Class),
    bbox_diagonal(X1a, Y1a, X2a, Y2a, DiagA),
    bbox_diagonal(X1b, Y1b, X2b, Y2b, DiagB),
    AvgSize is (DiagA + DiagB) / 2,
    center(X1a, Y1a, X2a, Y2a, Cx1, Cy1),
    center(X1b, Y1b, X2b, Y2b, Cx2, Cy2),
    Distance is sqrt((Cx1-Cx2)^2 + (Cy1-Cy2)^2),
    Distance < AvgSize * 2.  

adjacent_to(Object1Class, Object2Class, ImageID) :-
    detected(Object1Class, X1a, Y1a, X2a, Y2a, ImageID),
    detected(Object2Class, X1b, Y1b, X2b, Y2b, ImageID),
    object_category(Object1Class),
    object_category(Object2Class),
    allowed_adjacent_to(Object1Class, Object2Class),
    bbox_diagonal(X1a, Y1a, X2a, Y2a, Diag),
    Epsilon is Diag * 0.1,  
    ( (X2a >= X1b - Epsilon, X2a =< X1b + Epsilon)
    ; (X1a >= X2b - Epsilon, X1a =< X2b + Epsilon)
    ; (Y2a >= Y1b - Epsilon, Y2a =< Y1b + Epsilon)
    ; (Y1a >= Y2b - Epsilon, Y1a =< Y2b + Epsilon) ).


bbox_area(X1, Y1, X2, Y2, Area) :-
    Area is (X2 - X1) * (Y2 - Y1).

intersection_area(X1a, Y1a, X2a, Y2a, X1b, Y1b, X2b, Y2b, Area) :-
    IX1 is max(X1a, X1b),
    IY1 is max(Y1a, Y1b),
    IX2 is min(X2a, X2b),
    IY2 is min(Y2a, Y2b),
    Width is max(0, IX2 - IX1),
    Height is max(0, IY2 - IY1),
    Area is Width * Height.

bbox_diagonal(X1, Y1, X2, Y2, Diag) :-
    Diag is sqrt((X2 - X1)^2 + (Y2 - Y1)^2).