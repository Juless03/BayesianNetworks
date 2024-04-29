% GetValueOfAssignment Obtiene el valor de la variable asignada en el factor.
%
%   v = GetValueOfAssignment(F, A) retorna el valor de la variable asignada,
%   A, en el factor F. El orden de las variables en A se asume 
%   igual al orden en F.var.
%
%   v = GetValueOfAssignment(F, A, VO) obtiene el valor de la asignacion a la variable,
%   A, en el factor F. El orden de las variables en A esta dado por el vector VO.
%
%   See also SetValueOfAssignment.m and FactorTutorial.m

function v = GetValueOfAssignment(F, A, VO)

if (nargin == 2),
    indx = AssignmentToIndex(A, F.card);
else
    map = zeros(length(F.var), 1);
    for i = 1:length(F.var),
        map(i) = find(VO == F.var(i));
    end;
    indx = AssignmentToIndex(A(map), F.card);
end;

v = F.val(indx);

end
