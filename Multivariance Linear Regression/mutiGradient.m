%% ����һ���ݶ��½���
x = load('ex3x.dat');
y = load('ex3y.dat');

x = [ones(size(x,1),1) x];
meanx = mean(x);%���ֵ
sigmax = std(x);%���׼ƫ��
x(:,2) = (x(:,2)-meanx(2))./sigmax(2);
x(:,3) = (x(:,3)-meanx(3))./sigmax(3);

figure
itera_num = 100; %���Եĵ�������
sample_num = size(x,1); %ѵ�������Ĵ���
alpha = [0.01, 0.03, 0.1, 0.3, 1, 1.3];%��Ϊ�����ѡȡÿ��3����ѧϰ�������ԣ�����ֱ��ö�ٳ���
plotstyle = {'b', 'r', 'g', 'k', 'b--', 'r--'};

theta_grad_descent = zeros(size(x(1,:)));
 for alpha_i = 1:length(alpha) %���Կ��ĸ�ѧϰ�������
    theta = zeros(size(x,2),1); %theta�ĳ�ʼֵ��ֵΪ0
    Jtheta = zeros(itera_num, 1);
    for i = 1:itera_num %�����ĳ��ѧϰ����alpha�µ���itera_num������Ĳ���       
        Jtheta(i) = (1/(2*sample_num)).*(x*theta-y)'*(x*theta-y);%Jtheta�Ǹ�������
        grad = (1/sample_num).*x'*(x*theta-y);
        theta = theta - alpha(alpha_i).*grad;
    end
    plot(0:49, Jtheta(1:50),char(plotstyle(alpha_i)),'LineWidth', 2)%�˴�һ��Ҫͨ��char������ת��
    hold on
    
    if(1 == alpha(alpha_i)) %ͨ��ʵ�鷢��alphaΪ1ʱЧ����ã����ʱ�ĵ������thetaֵΪ�����ֵ
        theta_grad_descent = theta
    end
end
legend('0.01','0.03','0.1','0.3','1','1.3');
xlabel('Number of iterations')
ylabel('Cost function')

%������Ԥ�⹫ʽ
price_grad_descend = theta_grad_descent'*[1 (1650-meanx(2))/sigmax(2) (3-meanx(3)/sigmax(3))]'
                                     
                                     
%%��������normal equations
x = load('ex3x.dat');
y = load('ex3y.dat');
x = [ones(size(x,1),1) x];

theta_norequ = inv((x'*x))*x'*y
price_norequ = theta_norequ'*[1 1650 3]'