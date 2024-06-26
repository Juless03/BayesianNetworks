% Descripcion detallada de la estructura de factor y funciones relacionadas
% -----------------------------------------------------------------------
% Usaremos estructuras para implementar el tipo de dato factor. el código
%
%   phi = struct('var', [3 1 2], 'card', [2 2 2], 'val', ones(1, 8));
%
% crea un factor sobre las variables X_3, X_1, X_2, las cuales son todas binarias
% phi ha sido inicializado tal que 
% phi(X_3, X_1, X_2) = 1 para cualquier asignación de las variables
%
% Los valores de un factor se guardan en formato de filas el campo vector .val
% utilizando un ordenamiento como se expresa en el siguiente cuadro
%
% -+-----+-----+-----+-------------------+   
%  | X_3 | X_1 | X_2 | phi(X_3, X_1, X_2)|
% -+-----+-----+-----+-------------------+
%  |  1  |  1  |  1  |     phi.val(1)    |
% -+-----+-----+-----+-------------------+
%  |  2  |  1  |  1  |     phi.val(2)    |
% -+-----+-----+-----+-------------------+
%  |  1  |  2  |  1  |     phi.val(3)    |
% -+-----+-----+-----+-------------------+
%  |  2  |  2  |  1  |     phi.val(4)    |
% -+-----+-----+-----+-------------------+
%  |  1  |  1  |  2  |     phi.val(5)    |
% -+-----+-----+-----+-------------------+
%  |  2  |  1  |  2  |     phi.val(6)    |
% -+-----+-----+-----+-------------------+
%  |  1  |  2  |  2  |     phi.val(7)    |
% -+-----+-----+-----+-------------------+
%  |  2  |  2  |  2  |     phi.val(8)    |
% -+-----+-----+-----+-------------------+
%
%
% Se proveen las funciones AssignmentToIndex and IndexToAssignment
% que calculan este mapeo de asignaciones a indices y viceversa
% 
%   I = AssignmentToIndex(A, D)
%   A = IndexToAssignment(I, D)
%
% Poe ejemplo, para el factor definido arriba, con la assignation
%
%    A = [2 1 2] 
%
% para X_3, X_1 y X_2 respectivamente (dado por phi.var = [3 1 2]), I = 6 
% como phi.val(6) corresponde al valor de phi(X_3 = 2, X_1 = 1, X_2 = 2).
% Entonces, AssignmentToIndex([2 1 2], [2 2 2]) retorna 6, y conversamente, 
% IndexToAssignment(6, [2 2 2]) retorna el vector [2 1 2]. El segundo parametro
% en la funcion corresponde a la cardinalidad del factor phi, phi.card, que 
% en este ejemplo es [2 2 2].
%
% Mas generalmente, el vector de assignment A es un vector fila que corresponde
% a asignaciones a las variables del factor, bajo el entendido de que
% las variables para las cuales se refiere la asignacion se encuentran en el campo
% .var del factor. 
%
% Si le damos a AssignmentToIndex una matriz A, con una asignacion por fila, este
% retornara un vector de indices I, tal que I(k) es el indice que corresponde
% a la asignacion de A(k, :) (fila k). 
% 
% Conversamete, dar a IndexToAssignment un vector I de indices devuelve una
% matriz A de asignaciones, una por fila, tal que A(k, :) (la k-esima fila de A)
% corresponde a la assignacion rapeada por el indice I(k).
%
% Obtener y setear valores de los factores
% ----------------------------------------
%
% Se han proveido funciones para su convenienvia que son GetValueOfAssignment y
% SetValueOfAssignment tal que no hace falta manipular el campo .val 
% directamente para obtener y setear valores.
%
% Por ejemplo, al llamar 
%
%   GetValueOfAssignment(phi, [1 2 1]) 
%
% se obtiene el valor phi(X_3 = 1, X_1 = 2, X_2 = 1). De nuevo, las variables 
% para las que la asignacion se refire están dadas en el campo .var del factor factor.
%
% De la misma manera, el ejecutar
%
%    phi = SetValueOfAssignment(phi, [2 2 1], 6) 
%
% causa que el valor phi(X_3 = 2, X_1 = 2, X_2 = 1) cambie a 6. Note 
% que porque MATLAB/Octave pasa argumentos a una función por valor (no por 
% referencia), SetValueOfAssignment *no modifica* el factor que usted le 
% paso, mas bien returna un nuevo factor modificado con el valor
% especificado en la asignacion; por esto es que reasignamos phi al resultado
% de SetValueOfAssignment.
%
% Mas detalles sobre estas funciones son proveidos en sus respectivos archivos .m
%

% Ejemplos de Factors y Salidas
% -----------------------------
%
% En el siguiente codigo se ha proveido algunos ejemplos de factores de input,  
% asi como la salida que debe obtener cuando ejecuta las acciones sobre
% estos factores. Puede que encuentre estos ejemplos de inputs y outputs
% utiles para debuggear su implementacion. Por ejemplo, FACTORS.PRODUCT 
% es el factor que se debe obtener cuando ejecuta 
%
%   FactorProduct(FACTORS.INPUT(1), FACTORS.INPUT(2))
%
% Estos factores de ejemplo definen una red Bayesiana en cadena simple sobre variables binarias
% variables: X_1 -> X_2 -> X_3
%

% FACTORS.INPUT(1) contiene P(X_1)
FACTORS.INPUT(1) = struct('var', [1], 'card', [2], 'val', [0.11, 0.89]);

% FACTORS.INPUT(2) contiene P(X_2 | X_1)
FACTORS.INPUT(2) = struct('var', [2, 1], 'card', [2, 2], 'val', [0.59, 0.41, 0.22, 0.78]);

% FACTORS.INPUT(3) contiene P(X_3 | X_2)
FACTORS.INPUT(3) = struct('var', [3, 2], 'card', [2, 2], 'val', [0.39, 0.61, 0.06, 0.94]);

% Factor Product
% FACTORS.PRODUCT = FactorProduct(FACTORS.INPUT(1), FACTORS.INPUT(2));
% El factor aqui esta definido para estar correct a 4 decimales.
FACTORS.PRODUCT = struct('var', [1, 2], 'card', [2, 2], 'val', [0.0649, 0.1958, 0.0451, 0.6942]);

% Factor Marginalization
% FACTORS.MARGINALIZATION = FactorMarginalization(FACTORS.INPUT(2), [2]);
FACTORS.MARGINALIZATION = struct('var', [1], 'card', [2], 'val', [1 1]); 

% Observar Evidencia
% FACTORS.EVIDENCE = ObserveEvidence(FACTORS.INPUT, [2 1; 3 2]);
FACTORS.EVIDENCE(1) = struct('var', [1], 'card', [2], 'val', [0.11, 0.89]);
FACTORS.EVIDENCE(2) = struct('var', [2, 1], 'card', [2, 2], 'val', [0.59, 0, 0.22, 0]);
FACTORS.EVIDENCE(3) = struct('var', [3, 2], 'card', [2, 2], 'val', [0, 0.61, 0, 0]);

% Calcular distribucion conjunta
% FACTORS.JOINT = ComputeJointDistribution(FACTORS.INPUT);
FACTORS.JOINT = struct('var', [1, 2, 3], 'card', [2, 2, 2], 'val', [0.025311, 0.076362, 0.002706, 0.041652, 0.039589, 0.119438, 0.042394, 0.652548]);

% Calcular Marginal
%FACTORS.MARGINAL = ComputeMarginal([2, 3], FACTORS.INPUT, [1, 2]);
FACTORS.MARGINAL = struct('var', [2, 3], 'card', [2, 2], 'val', [0.0858, 0.0468, 0.1342, 0.7332]);
